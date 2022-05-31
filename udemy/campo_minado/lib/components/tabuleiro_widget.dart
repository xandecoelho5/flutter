import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

import '../models/campo.dart';

class TabuleiroWidget extends StatelessWidget {
  const TabuleiroWidget({
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlternarMarcacao,
    Key? key,
  }) : super(key: key);

  final Tabuleiro tabuleiro;
  final Function(Campo) onAbrir;
  final Function(Campo) onAlternarMarcacao;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: tabuleiro.colunas,
      children: tabuleiro.campos
          .map((c) => CampoWidget(
                campo: c,
                onAbrir: onAbrir,
                onAlternarMarcacao: onAlternarMarcacao,
              ))
          .toList(),
    );
  }
}
