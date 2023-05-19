import 'package:flutter/material.dart';
import 'package:quiz_app/db/db_helper.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/view/base/custom_border_shape.dart';

import '../base/custom_button.dart';
import 'add_question.dart';

class CreateQuizScreen extends StatefulWidget {
  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  List<QuestionModel> _questions = [];

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

  Future<void> _deleteQuestion(int questionId) async {
    await DatabaseHelper().deleteQuestion(questionId);
    await _loadQuestions();
  }

  void _navigateToAddQuestionScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewQuestionScreen()),
    );
    await _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CustomButton(
                title: 'Add New Question',
                onPressed: () => _navigateToAddQuestionScreen()),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];

                  // Find the correct answer
                  final correctAnswerIndex =
                      question.answers.indexWhere((answer) => answer.isCorrect);

                  return BorderShape(
                      widget: _buildListTile(question, correctAnswerIndex),
                      valColor: Colors.grey.shade200,
                      from: "1");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(QuestionModel question, int correctAnswerIndex) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              question.text,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onPressed: () => _alertDialog(question.id, context),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < question.answers.length; i++)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color:
                        i == correctAnswerIndex ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Text(
                  '${question.answers[i].text}',
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        i == correctAnswerIndex ? Colors.white : Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Future _alertDialog(int id, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete question',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            content: Text(
              'Are you sure you want to delete this question?',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Delete',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                onPressed: () {
                  _deleteQuestion(id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
