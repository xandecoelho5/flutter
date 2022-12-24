import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../repository/firebase_repository.dart';

class DeleteReplyUseCase {
  final FirebaseRepository repository;

  DeleteReplyUseCase(this.repository);

  Future<void> call(ReplyEntity reply) {
    return repository.deleteReply(reply);
  }
}
