import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../repository/firebase_repository.dart';

class LikeReplyUseCase {
  final FirebaseRepository repository;

  LikeReplyUseCase(this.repository);

  Future<void> call(ReplyEntity reply) {
    return repository.likeReply(reply);
  }
}
