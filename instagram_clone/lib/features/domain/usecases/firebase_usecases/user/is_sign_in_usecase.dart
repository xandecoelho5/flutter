import '../../../repository/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;

  IsSignInUseCase(this.repository);

  Future<bool> call() {
    return repository.isSignIn();
  }
}
