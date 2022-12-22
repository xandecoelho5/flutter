import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/repository/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;

  CreateUserUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return repository.createUser(user);
  }
}
