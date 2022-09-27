class Anime {
  final String name;
  final String score;
  final String imageUrl;
  final String synopsisImageUrl;
  final String synopsis;
  final String ageRatingGuide;
  final String ageRating;
  final String type;

  const Anime({
    required this.name,
    required this.score,
    required this.imageUrl,
    required this.synopsisImageUrl,
    required this.synopsis,
    required this.ageRatingGuide,
    required this.ageRating,
    required this.type,
  });

  factory Anime.fromMap(Map<String, dynamic> map) {
    final attributes = map['attributes'];

    getPosterImage() {
      return attributes['posterImage']['small'] ??
          attributes['posterImage']['tiny'] ??
          attributes['posterImage']['large'];
    }

    getCoverImage() {
      if (attributes['coverImage'] == null ||
          attributes['coverImage']?['meta']?['dimensions']?['tiny']?['width'] ==
              null) {
        return getPosterImage();
      }

      return attributes['coverImage']['tiny'] ??
          attributes['coverImage']['small'] ??
          attributes['coverImage']['large'];
    }

    return Anime(
      name: attributes['canonicalTitle'],
      score: attributes['averageRating'] ?? '0.00',
      imageUrl: getPosterImage(),
      synopsisImageUrl: getCoverImage(),
      synopsis: attributes['synopsis'],
      ageRating: attributes['ageRating'] ?? 'N/A',
      ageRatingGuide: attributes['ageRatingGuide'] ?? 'N/A',
      type: attributes['subtype'],
    );
  }
}
