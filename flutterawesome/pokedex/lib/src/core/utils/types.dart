import 'dart:ui';

enum PokemonType {
  normal(Color(0xFF9DA0AA)),
  fire(Color(0xFFFD7D24)),
  water(Color(0xFF4A90DA)),
  electric(Color(0xFFEED535)),
  grass(Color(0xFF62B957)),
  ice(Color(0xFF61CEC0)),
  fighting(Color(0xFFD04164)),
  poison(Color(0xFFA552CC)),
  ground(Color(0xFFDD7748)),
  flying(Color(0xFF748FC9)),
  psychic(Color(0xFFEA5D60)),
  bug(Color(0xFF8CB230)),
  rock(Color(0xFFBAAB82)),
  ghost(Color(0xFF556AAE)),
  dragon(Color(0xFF0F6AC0)),
  dark(Color(0xFF58575F)),
  steel(Color(0xFF417D9A)),
  fairy(Color(0xFFED6EC7));

  final Color color;

  const PokemonType(this.color);

  static Color getColorByName(String type) {
    return PokemonType.values
        .firstWhere((e) => e.name == type.toLowerCase())
        .color;
  }
}
