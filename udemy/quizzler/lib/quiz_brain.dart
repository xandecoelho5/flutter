import 'package:quizzler/question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final _questionBank = [
    const Question(
      question: 'Some cats are actually allergic to humans',
      answer: true,
    ),
    const Question(
      question: 'You can lead a cow down stairs but not up stairs.',
      answer: false,
    ),
    const Question(
      question: 'Approximately one quarter of human bones are in the feet.',
      answer: true,
    ),
    const Question(
      question: 'A slug\'s blood is green.',
      answer: true,
    ),
    const Question(
      question: 'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".',
      answer: true,
    ),
    const Question(
      question: 'It is illegal to pee in the Ocean in Portugal.',
      answer: true,
    ),
    const Question(
      question:
          'No piece of square dry paper can be folded in half more than 7 times.',
      answer: false,
    ),
    const Question(
      question:
          'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
      answer: true,
    ),
    const Question(
      question:
          'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
      answer: false,
    ),
    const Question(
      question:
          'The total surface area of two human lungs is approximately 70 square metres.',
      answer: true,
    ),
    const Question(
        question: 'Google was originally called \"Backrub\".', answer: true),
    const Question(
      question:
          'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
      answer: true,
    ),
    const Question(
      question:
          'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
      answer: true,
    ),
  ];

  void resetQuiz() => _questionNumber = 0;

  bool hasEnded() => _questionNumber == _questionBank.length - 1;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].question;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].answer;
  }
}
