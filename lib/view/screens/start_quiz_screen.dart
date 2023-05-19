import 'package:flutter/material.dart';
import 'package:quiz_app/db/db_helper.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/view/base/custom_border_shape.dart';
import 'package:quiz_app/view/screens/result_screen.dart';

class StartQuizScreen extends StatefulWidget {
  @override
  _StartQuizScreenState createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  List<QuestionModel> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool isFinished = false;
  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await DatabaseHelper().getAllQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void _answerSelected(int answerIndex) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final selectedAnswer = currentQuestion.answers[answerIndex];

    if (selectedAnswer.isCorrect) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      //   _showResultDialog();
      setState(() {
        isFinished = true;
      });
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Result'),
        content: Text('Your score: $_score/${_questions.length}'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: _questions.isEmpty || _questions.length < 5
                ? ResultScreen("Sorry!", "assets/faq.png", "",
                    "you must add at least 5 questions to start")
                : isFinished
                    ? _score / _questions.length >= 0.75
                        ? ResultScreen(
                            "Congratulations!",
                            "assets/result.jpg",
                            "your score: $_score/${_questions.length}",
                            "you a superstar")
                        : _score / _questions.length >= 0.5
                            ? ResultScreen(
                                "Congratulations!",
                                "assets/result.jpg",
                                "your score: $_score/${_questions.length}",
                                "keep up the good work!")
                            : ResultScreen(
                                "Oops!",
                                "assets/fail.png",
                                "your score: $_score/${_questions.length}",
                                "sorry, better luck next time!")
                    // : _questions.length < 5
                    //     ? ResultScreen("Sorry!", "assets/faq.png", "",
                    //         "you must add at least 5 questions to start")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Question ${_currentQuestionIndex + 1}',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal),
                              ),
                              Text(
                                '    / ${_questions.length}',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          BorderShape(
                            widget: Text(
                              _questions[_currentQuestionIndex].text,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            valColor: Colors.teal,
                          ),
                          SizedBox(height: 16),
                          Column(
                            children: [
                              for (int i = 0;
                                  i <
                                      _questions[_currentQuestionIndex]
                                          .answers
                                          .length;
                                  i++)
                                BorderShape(
                                  onTap: () => _answerSelected(i),
                                  widget: Text(_questions[_currentQuestionIndex]
                                      .answers[i]
                                      .text),
                                  valColor: Colors.white,
                                ),
                            ],
                          ),
                        ],
                      )));
  }
}
