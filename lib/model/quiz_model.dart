import 'package:quiz_app/model/question_model.dart';

class QuizModel {
  final int id;
  final String title;
  final List<QuestionModel> questions;

  QuizModel({required this.id, required this.title, required this.questions});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
