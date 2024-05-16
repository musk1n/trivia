import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trivia/main.dart';
import 'package:trivia/quiz_screen.dart';

class QuizEndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 250,
            ),
            Text(
              'Quiz Completed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.refresh),
              label: Text('Restart'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                exit(0);
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
