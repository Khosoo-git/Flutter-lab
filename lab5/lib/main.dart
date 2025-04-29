import 'package:flutter/material.dart';
import 'calculator.dart';
import 'history.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      initialRoute: '/',
      routes: {
        '/': (context) => CalculatorScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
