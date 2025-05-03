import 'package:flutter/material.dart';
import 'package:lab6/views/home_screen.dart';
import 'data/product_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductData(
      child: MaterialApp(
        title: 'E Commerce',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
