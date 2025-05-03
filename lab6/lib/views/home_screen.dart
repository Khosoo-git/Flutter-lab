import 'package:flutter/material.dart';
import 'package:lab6/views/product_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E Commerce'), backgroundColor: Colors.blue),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xFFF9F9E9), // цайвар шаргал өнгө
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-Commerce',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Cursive', // system cursive style
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'PRODUCTS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 200),
            _buildButton(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductScreen()),
              );
            }, "VIEW PRODUCTS"),
            SizedBox(height: 15),
            _buildButton(() {}, "UPDATE PRODUCTS"),
            SizedBox(height: 15),
            _buildButton(() {}, "ADD PRODUCTS"),
          ],
        ),
      ),
    );
  }
}

Widget _buildButton(VoidCallback? onPressed, String text) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 14),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(text),
    ),
  );
}
