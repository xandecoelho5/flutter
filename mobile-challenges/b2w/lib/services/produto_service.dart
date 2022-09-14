import 'package:b2w/services/uno_service.dart';

import '../models/produto.dart';

const url = '/produto';

class ProdutoService {
  final UnoService unoService;

  const ProdutoService(this.unoService);

  Future<List<Produto>> find() async {
    final response = await unoService.get(url);
    return _convertToProdutoList(response);
  }

  Future<List<Produto>> findByCategoria(int categoriaId, int limit) async {
    final response = await unoService.get(
      '$url?categoriaId=$categoriaId&limit=$limit',
    );
    final produtos = response['data'] as List;
    return produtos
        .map((p) => Produto.fromMap(p))
        .where((p) => p.categoria.id == categoriaId)
        .toList();
  }

  Future<List<Produto>> maisvendidos() async {
    final response = await unoService.get('$url/maisvendidos');
    return _convertToProdutoList(response);
  }

  Future<Produto> findBy(int produtoId) async {
    final response = await unoService.get('$url/$produtoId');
    return Produto.fromMap(response as Map<String, dynamic>);
  }

  Future<String> reservar(int produtoId) async {
    try {
      final response = await unoService.post('$url/$produtoId', {});
      return response['result'];
    } catch (e) {
      return 'failure';
    }
  }

  List<Produto> _convertToProdutoList(Map<String, dynamic> json) {
    final list = json['data'] as List;
    return list.map((p) => Produto.fromMap(p)).toList();
  }
}
