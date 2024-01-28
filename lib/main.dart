import 'package:counter_app/view/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.dark().copyWith(
        // Dark theme settings
        backgroundColor: Colors.black45,
        scaffoldBackgroundColor: Colors.black54,
      ),
      home: HomeScreen(),
    );
  }
}



