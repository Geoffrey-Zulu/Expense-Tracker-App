import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';
import 'statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase(); // This line initializes Firebase but returns void.
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Set the initial route to the HomeScreen
      routes: {
        '/home': (context) => HomeScreen(), // Add settings screen route
        '/settings': (context) => SettingsScreen(), // Add settings screen route
        '/statistics': (context) => StatisticsScreen(), // Add statistics screen route
      },
    );
  }
}

