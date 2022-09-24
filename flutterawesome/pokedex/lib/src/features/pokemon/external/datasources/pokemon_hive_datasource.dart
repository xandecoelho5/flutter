import 'package:hive_flutter/adapters.dart';
import 'package:pokedex/src/features/pokemon/domain/entities/pokemon_entity.dart';

import '../../domain/value_objects/base_stats.dart';
import '../../infra/datasources/pokemon_local_datasource.dart';

class PokemonHiveDatasource implements IPokemonLocalDatasource {
  Box<PokemonEntity>? _box;

  static final PokemonHiveDatasource _instance = PokemonHiveDatasource();

  static PokemonHiveDatasource getInstance() {
    return _instance;
  }

  PokemonHiveDatasource() {
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _open();
  }

  Future<void> _open() async {
    _box ??= await Hive.openBox('pokedex');
  }

  void _registerAdapters() {
    Hive.registerAdapter(PokemonEntityHiveAdapter());
    Hive.registerAdapter(BaseStatsAdapter());
    Hive.registerAdapter(HpAdapter());
    Hive.registerAdapter(AttackAdapter());
    Hive.registerAdapter(DefenseAdapter());
    Hive.registerAdapter(SpecialAttackAdapter());
    Hive.registerAdapter(SpecialDefenseAdapter());
    Hive.registerAdapter(SpeedAdapter());
    Hive.registerAdapter(AveragePowerAdapter());
  }

  @override
  Future<void> addFavouritePokemon(PokemonEntity pokemon) async {
    await _box!.put(pokemon.id.toString(), pokemon);
  }

  @override
  Future<Stream<List<PokemonEntity>>> getFavouritesPokemon() async {
    await _open();
    return _box!.watch().map((event) => _box!.values.toList());
  }

  @override
  Future<void> removeFavouritePokemon(PokemonEntity pokemon) async {
    await _box!.delete(pokemon.id.toString());
  }

  @override
  List<PokemonEntity> getAll() {
    return _box!.values.toList();
  }
}
