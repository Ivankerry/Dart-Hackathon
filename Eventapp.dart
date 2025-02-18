import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EventManagementApp());
}

class EventManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthWrapper(), // Main screen to check authentication status
    );
  }
}

// Authentication wrapper to check if the user is logged in or not
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading indicator while checking authentication
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!')); // Error message
        } else if (snapshot.hasData) {
          return HomeScreen(); // User is logged in, navigate to HomeScreen
        } else {
          return LoginScreen(); // User is not logged in, navigate to LoginScreen
        }
      },
    );
  }
}

// Home screen where the user can manage events
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to User Profile Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen()),
                );
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// Login screen for the user to authenticate
class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      // Attempt login using email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to the Home Screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      // Show error if login fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// User Profile Screen to manage user profile and display bookings
class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEditing = false;

  // Function to update the user's profile in Firestore
  Future<void> updateProfile(String name, String phone) async {
    final user = _auth.currentUser;
    if (user != null) {
      // Update the user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': name,
        'phone': phone,
      });
      setState(() {
        _isEditing = false; // Disable editing mode after saving
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: user == null
          ? Center(child: Text('Not logged in')) // If no user is logged in
          : FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Loading state
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}')); // Error state
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('User not found.')); // No user data
                }
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                _nameController.text = userData['name'];
                _phoneController.text = userData['phone'];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _isEditing
                          ? TextField(
                              controller: _nameController,
                              decoration: InputDecoration(labelText: 'Name'),
                            )
                          : Text('Name: ${userData['name']}'),
                      _isEditing
                          ? TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(labelText: 'Phone'),
                            )
                          : Text('Phone: ${userData['phone']}'),
                      SizedBox(height: 20),
                      _isEditing
                          ? ElevatedButton(
                              onPressed: () {
                                updateProfile(_nameController.text, _phoneController.text); // Save changes
                              },
                              child: Text('Save Changes'),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = true; // Enable editing mode
                                });
                              },
                              child: Text('Edit Profile'),
                            ),
                      SizedBox(height: 20),
                      // Display booked events from Firestore
                      Text('Booked Events:', style: TextStyle(fontSize: 18)),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('bookings')
                            .where('uid', isEqualTo: user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator()); // Loading state
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}')); // Error state
                          }
                          if (snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No events booked.')); // No bookings
                          }
                          var events = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              var event = events[index];
                              return ListTile(
                                title: Text(event['eventTitle']),
                                subtitle: Text(event['eventDate']),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
