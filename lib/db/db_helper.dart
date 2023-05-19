import 'package:path/path.dart';
import 'package:quiz_app/model/answer_model.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'quiz_app.db');

    return openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE questions ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'text TEXT, '
            'quiz_id INTEGER)');
        await db.execute('CREATE TABLE answers ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'question_id INTEGER, '
            'text TEXT, '
            'is_correct INTEGER)');
      },
    );
  }

  Future<List<QuestionModel>> getAllQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> questionMaps = await db.query('questions');
    final List<QuestionModel> questions = [];

    for (final questionMap in questionMaps) {
      final List<Map<String, dynamic>> answerMaps = await db.query(
        'answers',
        where: 'question_id = ?',
        whereArgs: [questionMap['id']],
      );
      final List<AnswerModel> answers = answerMaps.map((map) {
        return AnswerModel(
          id: map['id'],
          questionId: map['question_id'],
          text: map['text'],
          isCorrect: map['is_correct'] == 1,
        );
      }).toList();

      final question = QuestionModel(
        id: questionMap['id'],
        quizId: questionMap['quiz_id'],
        text: questionMap['text'],
        answers: answers,
      );

      questions.add(question);
    }

    return questions;
  }

  Future<void> insertQuestionWithAnswers(String questionText,
      List<String> answerTexts, int correctAnswerIndex) async {
    final db = await database;
    final question = {
      'text': questionText,
      'quiz_id': 1, // Replace with the actual quiz ID
    };
    final questionId = await db.insert('questions', question);

    final batch = db.batch();
    for (final answerText in answerTexts) {
      final isCorrect =
          answerTexts.indexOf(answerText) == correctAnswerIndex ? 1 : 0;
      final answer = {
        'question_id': questionId,
        'text': answerText,
        'is_correct': isCorrect,
      };
      batch.insert('answers', answer);
    }

    await batch.commit();
  }

  Future<void> deleteQuestion(int questionId) async {
    final db = await database;
    await db.delete(
      'questions',
      where: 'id = ?',
      whereArgs: [questionId],
    );
    await db.delete(
      'answers',
      where: 'question_id = ?',
      whereArgs: [questionId],
    );
  }
}
