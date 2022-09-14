class BannerModel {
  final int id;
  final String linkUrl;
  final String urlImagem;

  const BannerModel({
    required this.id,
    required this.linkUrl,
    required this.urlImagem,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int,
      linkUrl: map['linkUrl'] as String,
      urlImagem: map['urlImagem'] as String,
    );
  }
}
