import 'package:flutter/material.dart';
import 'package:tcc/screens/welcome/welcome_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAPEM',
      theme: ThemeData(
        
      ),
      home: WelcomeScreen(),
    );
  }
}

