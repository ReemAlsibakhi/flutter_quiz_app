import 'package:flutter/material.dart';

import '../../db/db_helper.dart';
import '../base/custom_button.dart';
import '../base/custom_circular_image.dart';

class AddNewQuestionScreen extends StatefulWidget {
  @override
  _AddNewQuestionScreenState createState() => _AddNewQuestionScreenState();
}

class _AddNewQuestionScreenState extends State<AddNewQuestionScreen> {
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _answerControllers = [];

  int selectedIndex = 0; // Initially selected index
  @override
  void initState() {
    super.initState();
    _answerControllers.add(TextEditingController());
    _answerControllers.add(TextEditingController());
    _answerControllers.add(TextEditingController());
    _answerControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveQuestion() async {
    final questionText = _questionController.text;
    final List<String> answers =
        _answerControllers.map((controller) => controller.text).toList();

    await DatabaseHelper()
        .insertQuestionWithAnswers(questionText, answers, selectedIndex);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  hintText: 'Enter the question',
                  // errorText: 'Error message',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.question_mark,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularImage("A", Colors.orange),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _answerControllers[0],
                      decoration: const InputDecoration(
                        labelText: 'First Answer',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularImage("B", Colors.green),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _answerControllers[1],
                      decoration: const InputDecoration(
                        labelText: 'Second Answer',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularImage("C", Colors.grey),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _answerControllers[2],
                      decoration: const InputDecoration(
                        labelText: 'Third Answer',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularImage("D", Colors.red),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _answerControllers[3],
                      decoration: const InputDecoration(
                        labelText: 'Fourth Answer',
                        // errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Select the correct answer:',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    value: selectedIndex,
                    style: TextStyle(color: Colors.teal, fontSize: 18),
                    onChanged: (newIndex) {
                      setState(() {
                        selectedIndex = newIndex!; // Update the selected index
                      });
                    },
                    items: const [
                      DropdownMenuItem<int>(
                        value: 0,
                        child: Text('A'),
                      ),
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text('B'),
                      ),
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('C'),
                      ),
                      DropdownMenuItem<int>(
                        value: 3,
                        child: Text('D'),
                      ),
                    ],
                  ),
                ],
              ),
              CustomButton(
                title: 'Add Question',
                onPressed: () => _saveQuestion(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
