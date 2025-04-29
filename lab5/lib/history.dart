import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> history =
        ModalRoute.of(context)!.settings.arguments
            as List<Map<String, String>>? ??
        [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                '${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              history[index]['result']!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              history[index]['expression']!,
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
