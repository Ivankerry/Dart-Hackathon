import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Entry point of the Flutter application
void main() => runApp(const FitnessTrackerApp());

// Main app widget
class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(), // Sets the home screen
    );
  }
}

// Stateful widget for handling bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Keeps track of the selected tab
  final List<Widget> _screens = [
    const DashboardScreen(),
    const WorkoutScreen(),
    const ActivityScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {}, // Placeholder for notifications
          ),
        ],
      ),
      body: _screens[_currentIndex], // Displays the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logActivity(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Opens a bottom sheet to log new activity
  void _logActivity(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Log New Activity', style: TextStyle(fontSize: 20)),
            NumberInputWithIncrementDecrement(
              controller: TextEditingController(),
              min: 0,
              max: 10000,
              initialValue: 5000,
              decoration: const InputDecoration(labelText: 'Steps'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Closes the sheet
              child: const Text('Save Activity'),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard screen widget
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const _DailyProgressCard(),
          const SizedBox(height: 20),
          _buildActivityChart(),
          const SizedBox(height: 20),
          const _QuickStatsGrid(),
        ],
      ),
    );
  }

  // Builds the activity chart
  Widget _buildActivityChart() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        LineSeries<ActivityData, String>(
          dataSource: [
            ActivityData('Mon', 5000),
            ActivityData('Tue', 7500),
            ActivityData('Wed', 3000),
            ActivityData('Thu', 10000),
            ActivityData('Fri', 6000),
            ActivityData('Sat', 8500),
            ActivityData('Sun', 4000),
          ],
          xValueMapper: (ActivityData data, _) => data.day,
          yValueMapper: (ActivityData data, _) => data.steps,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

// Data model for activity data
class ActivityData {
  final String day;
  final int steps;
  ActivityData(this.day, this.steps);
}

// Placeholder widgets for other screens
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});
  @override
  Widget build(BuildContext context) => Container();
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});
  @override
  Widget build(BuildContext context) => Container();
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Container();
}
