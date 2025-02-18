# Fitness App

A Flutter-based fitness application designed to help users track their daily workouts, steps, and overall progress.

## Features
- **Dashboard**: Displays daily fitness statistics and progress.
- **Workout Tracking**: Log different workout types with duration and calorie tracking.
- **Step Counter**: Track steps taken daily.
- **Activity History**: View past activities in an organized manner.
- **Profile Management**: Update and manage user profile details.

## Technologies Used
- Flutter (Dart)
- Syncfusion Charts for data visualization
- Number Input Increment/Decrement package for user input

## Getting Started

### Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install) and set up your environment.
- Clone this repository:
  ```bash
  git clone https://github.com/yourusername/fitness-app.git
  cd fitness-app
  ```
- Install dependencies:
  ```bash
  flutter pub get
  ```

### Running the App
To run the application on an emulator or device:
```bash
flutter run
```

# E-Learning Platform

An interactive E-Learning platform built with Flutter to provide video lessons and quizzes for learners. Users can browse courses, watch videos, take quizzes, and track their progress.

## Features

- **Course Browsing**: Browse available courses and select one to view details.
- **Video Streaming**: Watch video lessons within each course.
- **Quizzes**: Answer multiple-choice, true/false, and rating-based questions.
- **Progress Tracker**: Track and view quiz scores and results after completing each quiz.

## Screens

1. **Home Screen**: Allows users to browse available courses.
2. **Courses Screen**: Displays a list of courses with a description.
3. **Course Detail Screen**: Displays video lessons for the selected course and provides an option to take a quiz.
4. **Quiz Screen**: Allows users to answer questions based on the course content. The quiz includes:
   - Multiple-choice questions
   - True/False questions
   - Rating-based questions
5. **Progress Screen**: Displays the final score, correct answers, and time taken for each question.

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter (latest stable version)
- Android Studio or Visual Studio Code with Flutter and Dart extensions
- A Firebase project with Cloud Firestore set up (for further integration)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/elearning-platform.git

2. Navigate to the project directory:

cd elearning-platform


3. Install dependencies:

flutter pub get


4. Run the app:

flutter run



Firebase Setup (Optional)

1. Set up Firebase for your Flutter project by following the Firebase Flutter Setup.


2. Update your Firebase configuration with the appropriate settings for Android/iOS as required.


3. Ensure Firestore is enabled in your Firebase Console and set up the necessary collections (users, courses, and quizzes).



App Structure

main.dart: Entry point of the app, responsible for setting up routes and navigation.

HomeScreen.dart: Displays the home page and allows navigation to the Courses Screen.

CoursesScreen.dart: Displays a list of available courses.

CourseDetailScreen.dart: Displays video content and allows users to take the quiz.

QuizScreen.dart: Handles the quiz logic, including timer and score tracking.

ProgressScreen.dart: Displays final quiz results and user progress.


Libraries Used

flutter: The primary SDK for building cross-platform apps.

video_player: For embedding video content in the app.

flutter_localizations: For localization and supporting multiple languages (if needed).

firebase_auth: For user authentication (if integrated in the future).

cloud_firestore: For storing quiz and course data in Firebase Firestore (if integrated in the future).


Contributing

Feel free to fork this repository, open issues, and submit pull requests. Please follow the standard GitHub flow for contributions.

Steps to Contribute:

1. Fork the repository


2. Create a new branch (git checkout -b feature/your-feature-name)


3. Commit your changes (git commit -am 'Add new feature')


4. Push to your branch (git push origin feature/your-feature-name)


5. Create a new Pull Request


