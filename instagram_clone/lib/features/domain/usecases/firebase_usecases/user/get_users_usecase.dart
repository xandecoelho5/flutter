import '../../../entities/user/user_entity.dart';
import '../../../repository/firebase_repository.dart';

class GetUsersUseCase {
  final FirebaseRepository repository;

  GetUsersUseCase(this.repository);

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}
