import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String title;
  final String body;

  NotificationScreen({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(body),
      ),
    );
  }
}
