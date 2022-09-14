import 'package:b2w/main.dart';
import 'package:b2w/models/produto.dart';
import 'package:b2w/services/produto_service.dart';
import 'package:b2w/utils/constants.dart';
import 'package:b2w/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProdutoScreen extends StatefulWidget {
  const ProdutoScreen({Key? key}) : super(key: key);

  @override
  State<ProdutoScreen> createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  bool isReserving = false;

  Future<void> reservar(produtoId) async {
    setState(() => isReserving = true);
    final response = await getIt.get<ProdutoService>().reservar(produtoId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            response == 'success'
                ? 'Produto reservado com sucesso'
                : 'Falha ao reservar o produto',
            style: kReservado),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    setState(() => isReserving = false);
  }

  @override
  Widget build(BuildContext context) {
    final produto = ModalRoute.of(context)!.settings.arguments as Produto;

    return Scaffold(
      appBar: AppBar(title: Text(produto.categoria.descricao)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  height: 125,
                  width: 150,
                  child: fetchImage(produto.urlImagem),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(produto.nome, style: kDescricaoProduto),
            ),
            kDivider,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
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
            ),
            kDivider,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text('Descricão detalhada:', style: kDescricaoProduto2),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: HtmlWidget(produto.descricao),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isReserving ? null : () => reservar(produto.id),
        backgroundColor: isReserving ? Colors.grey : kWarmPurple,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
