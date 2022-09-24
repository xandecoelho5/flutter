import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pokedex/src/features/pokemon/domain/value_objects/base_stats.dart';

part 'pokemon_entity.g.dart';

@HiveType(typeId: 1)
class PokemonEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final List<dynamic> types;
  @HiveField(4)
  final int height;
  @HiveField(5)
  final int weight;
  @HiveField(6)
  final BaseStats baseStats;
  @HiveField(7)
  bool isFavourite;

  PokemonEntity({
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
