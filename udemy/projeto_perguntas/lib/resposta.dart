import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  Resposta(this.texto, this.quandoSelecionado, {Key? key}) : super(key: key);

  final String texto;
  final void Function() quandoSelecionado;

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(color: Colors.white), primary: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style,
        onPressed: quandoSelecionado,
        child: Text(texto),
      ),
    );
  }
}
