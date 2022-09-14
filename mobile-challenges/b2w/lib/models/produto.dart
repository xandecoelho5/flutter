import 'package:b2w/models/categoria.dart';

class Produto {
  final int id;
  final String nome;
  final String descricao;
  final int precoDe;
  final double precoPor;
  final String urlImagem;
  final Categoria categoria;

  const Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.precoDe,
    required this.precoPor,
    required this.urlImagem,
    required this.categoria,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      precoDe: map['precoDe'],
      precoPor: map['precoPor'],
      urlImagem: map['urlImagem'],
      categoria: Categoria.fromMap(map['categoria']),
    );
  }
}
