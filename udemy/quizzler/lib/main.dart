import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(const Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> _scoreKeeper = [];

  void _checkAnswer(bool userPickedAnswer) {
    if (quizBrain.hasEnded()) {
      Alert(
        context: context,
        title: "Finished!",
        desc: "You've reached the end of the quiz.",
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                quizBrain.resetQuiz();
                _scoreKeeper.clear();
                Navigator.pop(context);
              });
            },
            width: 120,
            child: const Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    } else {
      setState(() {
        bool correctAnswer = quizBrain.getQuestionAnswer();
        if (userPickedAnswer == correctAnswer) {
          _scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          _scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        }

        quizBrain.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () => _checkAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () => _checkAnswer(false),
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        ),
      ],
    );
  }
}
