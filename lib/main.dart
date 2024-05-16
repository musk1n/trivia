import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trivia/quiz_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  final String apiKey = 'https://opentdb.com/api.php?amount=10&type=multiple';
  final String baseUrl = 'https://opentdb.com/api.php';

  Future<List<dynamic>> fetchQuestions(String categoryId) async {
    final url = '$baseUrl?amount=10&category=$categoryId&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body)['results'];
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.deepPurple,
                    size: 24,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "100",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Positioned(
              top: -250,
              left: -200,
              child: Container(
                width: 800,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Category',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(500),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Category containers will be added here
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('9');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('General Knowledge', Icons.account_balance),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('23');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('History', Icons.account_tree_outlined),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('27');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Animals', Icons.adb),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('26');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Celebrities', Icons.account_box),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('21');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Sports', Icons.accessibility_new),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('18');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Science & Nature', Icons.ac_unit),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('25');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Art', Icons.category),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<dynamic> questions = await fetchQuestions('20');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(questions),
                            ),
                          );
                        },
                        child: _buildCategoryContainer('Mythology', Icons.account_balance_wallet),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContainer(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
