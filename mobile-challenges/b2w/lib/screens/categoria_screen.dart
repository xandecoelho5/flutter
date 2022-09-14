import 'package:b2w/main.dart';
import 'package:b2w/models/categoria.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../services/produto_service.dart';
import '../widgets/produto_list.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({Key? key}) : super(key: key);

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  late EasyRefreshController _controller;
  List<Produto> produtos = [];
  late int categoriaId;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> findProdutosByCategoria(limit) async {
    produtos =
        await getIt.get<ProdutoService>().findByCategoria(categoriaId, limit);
  }

  _onRefresh() async {
    await findProdutosByCategoria(20);
    setState(() {
      _controller.finishRefresh();
      _controller.resetFooter();
    });
  }

  _onLoad() async {
    final size = produtos.length;
    await findProdutosByCategoria(produtos.length + 10);
    setState(() {
      _controller.finishLoad(
        size >= produtos.length
            ? IndicatorResult.noMore
            : IndicatorResult.success,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoria = ModalRoute.of(context)!.settings.arguments as Categoria;
    categoriaId = categoria.id;

    return Scaffold(
      appBar: AppBar(title: Text(categoria.descricao)),
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(
          dragText: 'Puxe para atualizar',
          armedText: 'Solte para atualizar',
          readyText: 'Atualizando...',
          processingText: 'Atualizando...',
          processedText: 'Atualizado',
          messageText: 'última atualização às %T',
        ),
        footer: const ClassicFooter(
          readyText: 'Carregando...',
          processingText: 'Carregando...',
          processedText: 'Carregado',
          noMoreText: 'Sem mais produtos',
          messageText: 'última atualização às %T',
        ),
        onRefresh: _onRefresh,
        onLoad: _onLoad,
        refreshOnStart: true,
        child: ProdutoList(produtos: produtos),
      ),
    );
  }
}
