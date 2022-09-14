import 'package:b2w/utils/constants.dart';
import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/drawable-mdpi/logo_sobre.png',
                height: 140,
                width: 140,
              ),
              const SizedBox(height: 10),
              const Text('a Lodjinha', style: kLogoSobre),
            ],
          ),
          Column(
            children: const [
              Text(
                'Desenvolvido por Xandecoelho5',
                style: kNomeDesenvolvedor,
              ),
              SizedBox(height: 8),
              Text('14 de setembro de 2022', style: kDataDesenvolvimento),
            ],
          )
        ],
      ),
    );
  }
}
