import 'package:b2w/models/produto.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class ProdutoItem extends StatelessWidget {
  const ProdutoItem({Key? key, required this.produto}) : super(key: key);

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.produto,
        arguments: produto,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(flex: 2, child: fetchImage(produto.urlImagem)),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(produto.nome, style: kDescricaoProduto),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'De: ${produto.precoDe}'.replaceAll('.', ','),
                          style: kPrecoDe,
                        ),
                        Text(
                          'Por ${produto.precoPor}'.replaceAll('.', ','),
                          style: kPrecoPor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Image.asset('assets/images/drawable-mdpi/disclosure_indicator.png'),
          ],
        ),
      ),
    );
  }
}
