import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

import '../../../repository/firebase_repository.dart';

class GetSingleOtherUserUseCase {
  final FirebaseRepository repository;

  GetSingleOtherUserUseCase(this.repository);

  Stream<List<UserEntity>> call(String otherUid) {
    return repository.getSingleOtherUser(otherUid);
  }
}
