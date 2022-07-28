enum GenerationOptions {
  first(1, 151),
  second(2, 251),
  third(3, 386),
  fourth(4, 494),
  fifth(5, 649),
  sixth(6, 721),
  seventh(7, 809),
  eighth(8, 898);

  const GenerationOptions(this.generationNumber, this.lastPokedexNumber);

  final int generationNumber;
  final int lastPokedexNumber;

  static GenerationOptions getGenerationByPokedexNumber(int pokedexNumber) {
    for (var generation in values) {
      if (pokedexNumber <= generation.lastPokedexNumber) {
        return generation;
      }
    }
    return eighth;
  }
}
