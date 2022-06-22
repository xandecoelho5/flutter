import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;

  List? questions;
  int _currentQuestionCount = 0;
  int _correctAnswers = 0;

  BuildContext context;
  String difficulty;

  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    final response = await _dio.get('/', queryParameters: {
      'amount': _maxQuestions,
      'type': 'boolean',
      'difficulty': difficulty.toLowerCase(),
    });
    questions = response.data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]['correct_answer'] == answer;

    _currentQuestionCount++;
    if (isCorrect) {
      _correctAnswers++;
    }

    await _showQuestionAnswer(isCorrect);

    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> _showQuestionAnswer(bool isCorrect) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context);
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'End Game!',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          content: Text('Score: $_correctAnswers/$_maxQuestions'),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
