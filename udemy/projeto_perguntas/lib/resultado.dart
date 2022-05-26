import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  Resultado(this.pontuacao, this.quandoReiniciarQuestionario, {Key? key}) : super(key: key);

  final int pontuacao;
  final void Function() quandoReiniciarQuestionario;

  final ButtonStyle style =
      TextButton.styleFrom(textStyle: const TextStyle(color: Colors.white), primary: Colors.blue);

  String get fraseResultado {
    if (pontuacao < 8) return 'Parabéns!';
    if (pontuacao < 12) return 'Você é bom!';
    if (pontuacao < 16) return 'Impressionante!';
    return 'Nível Jedi';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(fraseResultado, style: const TextStyle(fontSize: 28)),
        ),
        TextButton(
          onPressed: quandoReiniciarQuestionario,
          style: style,
          child: const Text(
            'Reiniciar?',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
