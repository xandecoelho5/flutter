class Evolution {
  final int basePokemonId;
  final String basePokemonName;
  final int level;
  final int nextPokemonId;
  final String nextPokemonName;

  const Evolution({
    required this.basePokemonId,
    required this.level,
    required this.nextPokemonId,
    required this.basePokemonName,
    required this.nextPokemonName,
  });
}
