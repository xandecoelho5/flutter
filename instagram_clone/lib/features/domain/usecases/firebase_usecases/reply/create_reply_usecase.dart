import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../repository/firebase_repository.dart';

class CreateReplyUseCase {
  final FirebaseRepository repository;

  CreateReplyUseCase(this.repository);

  Future<void> call(ReplyEntity reply) {
    return repository.createReply(reply);
  }
}
