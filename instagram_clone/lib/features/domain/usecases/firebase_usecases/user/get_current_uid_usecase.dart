import '../../../repository/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository repository;

  GetCurrentUidUseCase(this.repository);

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
