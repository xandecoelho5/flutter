class Categoria {
  final int id;
  final String descricao;
  final String urlImagem;

  const Categoria({
    required this.id,
    required this.descricao,
    required this.urlImagem,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      urlImagem: map['urlImagem'] as String,
    );
  }

  @override
  String toString() {
    return 'Categoria{id: $id, descricao: $descricao, urlImagem: $urlImagem}';
  }
}
