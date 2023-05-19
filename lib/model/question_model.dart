import 'package:quiz_app/model/answer_model.dart';

class QuestionModel {
  final int id;
  final int quizId;
  final String text;
  final List<AnswerModel> answers;

  QuestionModel(
      {required this.id,
      required this.quizId,
      required this.text,
      required this.answers});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_id': quizId,
      'text': text,
    };
  }
}
