import 'package:equatable/equatable.dart';
import 'package:pokedex/src/features/pokemon/domain/value_objects/base_stats.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<dynamic> types;
  final bool isFavourite;
  final int height;
  final int weight;
  final BaseStats baseStats;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseStats,
    this.isFavourite = false,
  });

  double get bmi => weight / (height * height);

  @override
  List<Object> get props => [id];
}
