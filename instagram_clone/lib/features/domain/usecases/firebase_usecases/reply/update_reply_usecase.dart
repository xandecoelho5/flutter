import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../repository/firebase_repository.dart';

class UpdateReplyUseCase {
  final FirebaseRepository repository;

  UpdateReplyUseCase(this.repository);

  Future<void> call(ReplyEntity reply) {
    return repository.updateReply(reply);
  }
}
