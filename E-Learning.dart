import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(ElearningApp());
}

class ElearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Platform',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Learning Platform'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursesScreen()),
                );
              },
              child: Text('Browse Courses'),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Flutter Development'),
            subtitle: Text('Learn to build mobile apps with Flutter.'),
            trailing: Icon(Icons.play_circle_fill),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseDetailScreen(courseTitle: 'Flutter Development')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CourseDetailScreen extends StatefulWidget {
  final String courseTitle;

  CourseDetailScreen({required this.courseTitle});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://www.example.com/sample-video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen(courseTitle: widget.courseTitle)),
              );
            },
            child: Text('Take Quiz'),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String courseTitle;

  QuizScreen({required this.courseTitle});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  int questionIndex = 0;
  int timeLeft = 30; // 30 seconds per question
  late Timer _timer;
  Map<String, dynamic> questionResults = {};
  bool isAnswerSelected = false;
  bool isQuizFinished = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is Flutter?',
      'type': 'multiple_choice',
      'options': ['A programming language', 'A UI toolkit', 'A database', 'A framework'],
      'answer': 'A UI toolkit',
    },
    {
      'question': 'Flutter is open-source?',
      'type': 'true_false',
      'options': ['True', 'False'],
      'answer': 'True',
    },
    {
      'question': 'Rate your knowledge of Dart',
      'type': 'rating',
      'min': 1,
      'max': 5,
      'answer': 4,
    },
  ];

  void checkAnswer(dynamic selectedAnswer, dynamic correctAnswer) {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an answer!')));
      return;
    }

    setState(() {
      isAnswerSelected = true;
      if (selectedAnswer == correctAnswer) {
        score++;
      }

      questionResults[questionIndex.toString()] = {
        'question': questions[questionIndex]['question'],
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
        'timeTaken': 30 - timeLeft,
      };
    });

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        timeLeft = 30; // Reset timer for the next question
        isAnswerSelected = false;
      });
      startTimer();
    } else {
      setState(() {
        isQuizFinished = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProgressScreen(score: score, questionResults: questionResults)),
      );
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        checkAnswer(null, questions[questionIndex]['answer']);
      } else {
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseTitle} Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isQuizFinished) ...[
              Text('Time Left: $timeLeft seconds', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(currentQuestion['question'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              if (currentQuestion['type'] == 'multiple_choice')
                ...currentQuestion['options'].map<Widget>((option) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: GestureDetector(
                      key: ValueKey(option),
                      onTap: () {
                        checkAnswer(option, currentQuestion['answer']);
                      },
                      child: Card(
                        elevation: 5,
                        color: isAnswerSelected && option == currentQuestion['answer']
                            ? Colors.green
                            : isAnswerSelected && option != currentQuestion['answer']
                                ? Colors.red
                                : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(option, style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              if (currentQuestion['type'] == 'true_false')
                ...['True', 'False'].map<Widget>((option) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: GestureDetector(
                      key: ValueKey(option),
                      onTap: () {
                        checkAnswer(option, currentQuestion['answer']);
                      },
                      child: Card(
                        elevation: 5,
                        color: isAnswerSelected && option == currentQuestion['answer']
                            ? Colors.green
                            : isAnswerSelected && option != currentQuestion['answer']
                                ? Colors.red
                                : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(option, style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              if (currentQuestion['type'] == 'rating')
                Slider(
                  value: (currentQuestion['answer'] as int).toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (value) {
                    checkAnswer(value.round(), currentQuestion['answer']);
                  },
                ),
              SizedBox(height: 20),
              if (isAnswerSelected)
                ElevatedButton(
                  onPressed: () {
                    if (questionIndex < questions.length - 1) {
                      setState(() {
                        isAnswerSelected = false;
                      });
                    }
                  },
                  child: Text('Next Question'),
                ),
            ] else ...[
              Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final int score;
  final Map<String, dynamic> questionResults;

  ProgressScreen({required this.score, required this.questionResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Final Score: $score/${questionResults.length}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questionResults.length,
                itemBuilder: (context, index) {
                  var result = questionResults[index.toString()];
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(result['question'], style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          Text('Your Answer: ${result['selectedAnswer']}'),
                          Text('Correct Answer: ${result['correctAnswer']}'),
                          Text('Time Taken: ${result['timeTaken']} seconds'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
