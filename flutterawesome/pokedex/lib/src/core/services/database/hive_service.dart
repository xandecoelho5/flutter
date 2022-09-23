import 'package:hive_flutter/adapters.dart';
import 'package:pokedex/src/core/services/database/local_database_service.dart';

class HiveService implements LocalDatabaseService {
  late final Box _box;

  HiveService() {
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('pokedex');
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<T> get<T>(String key) {
    return _box.get(key);
  }

  @override
  Future<void> save<T>(String key, T value) async {
    await _box.put(key, value);
  }
}
