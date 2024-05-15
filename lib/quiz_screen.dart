import 'package:flutter/material.dart';
import 'package:trivia/quiz_end_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Which planet is the Largest?',
      'options': ['Mars', 'Venus', 'Jupiter', 'Mercury'],
      'correctAnswer': 'Jupiter',
    },
    //.....etc.
  ];
  String _selectedOption = '';
  bool _showFeedback = false;
  bool _answerSubmitted = false;

  void _submitAnswer(String selectedOption) {
    if (!_answerSubmitted) {
      setState(() {
        _selectedOption = selectedOption;
        _answerSubmitted = true;
        _showFeedback = true;
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      _selectedOption = '';
      _showFeedback = false;
      _answerSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${_questionIndex + 1}:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _questions[_questionIndex]['question'],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Column(
                  children: (_questions[_questionIndex]['options'] as List<String>).map<Widget>((option) {
                    bool isCorrect = option == _questions[_questionIndex]['correctAnswer'];
                    bool isSelected = option == _selectedOption;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: _answerSubmitted
                            ? null
                            : () {
                          _submitAnswer(option);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                if (isSelected && !isCorrect) {
                                  return Colors.red;
                                } else if (isSelected && isCorrect) {
                                  return Colors.green;
                                } else if (!isSelected && isCorrect) {
                                  return Colors.green;
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                _showFeedback
                    ? _selectedOption == _questions[_questionIndex]['correctAnswer']
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Correct!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Incorrect! Correct answer: ${_questions[_questionIndex]['correctAnswer']}',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : SizedBox(),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: _answerSubmitted
                      ? _questionIndex == _questions.length - 1
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizEndScreen()),
                    );
                  }
                      : _nextQuestion
                      : null,
                  child: Text(
                    _questionIndex == _questions.length - 1 ? 'Finish' : 'Next Question',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}