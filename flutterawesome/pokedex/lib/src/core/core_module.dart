import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/pokemon')),
          export: true,
        ),
      ];
}
