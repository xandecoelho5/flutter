abstract class LocalDatabaseService {
  // Future<void> init();
  // Future<void> close();
  // Future<void> clear();
  Future<void> save<T>(String key, T value);
  Future<T> get<T>(String key);
  Future<void> delete(String key);
}
