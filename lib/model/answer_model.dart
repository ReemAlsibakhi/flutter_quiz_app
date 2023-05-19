class AnswerModel {
  final int id;
  final int questionId;
  final String text;
  final bool isCorrect;

  AnswerModel(
      {required this.id,
      required this.questionId,
      required this.text,
      required this.isCorrect});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question_id': questionId,
      'text': text,
      'is_correct': isCorrect ? 1 : 0,
    };
  }
}

///
