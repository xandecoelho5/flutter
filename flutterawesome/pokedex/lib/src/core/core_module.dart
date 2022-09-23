import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex/src/core/services/database/hive_service.dart';
import 'package:pokedex/src/core/services/database/local_database_service.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/pokemon')),
          export: true,
        ),
        Bind.singleton<LocalDatabaseService>(
          (i) => HiveService(),
          export: true,
        ),
      ];
}
