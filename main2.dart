import 'package:flutter/material.dart';
import 'package:weather_app/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
