import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;

  GamePageProvider? _pageProvider;
  String difficulty;

  GamePage({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => GamePageProvider(context: context, difficulty: difficulty),
      child: _buildUi(),
    );
  }

  Widget _buildUi() {
    return Builder(builder: (ctx) {
      _pageProvider = ctx.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
              child: _gameUi(),
            ),
          ),
        );
      }
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    });
  }

  Widget _gameUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _questionText(),
        Column(
          children: [
            _button('True', Colors.green),
            SizedBox(height: _deviceHeight! * 0.01),
            _button('False', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _button(String text, Color color) {
    return MaterialButton(
      onPressed: () => _pageProvider!.answerQuestion(text),
      color: color,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
