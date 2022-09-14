import 'package:b2w/widgets/produto_item.dart';
import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../utils/constants.dart';

class ProdutoList extends StatelessWidget {
  const ProdutoList({Key? key, required this.produtos}) : super(key: key);

  final List<Produto> produtos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      itemCount: produtos.length,
      itemBuilder: (ctx, i) => ProdutoItem(produto: produtos[i]),
      separatorBuilder: (ctx, i) => kDivider,
    );
  }
}
