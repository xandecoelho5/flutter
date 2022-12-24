import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../repository/firebase_repository.dart';

class ReadRepliesUseCase {
  final FirebaseRepository repository;

  ReadRepliesUseCase(this.repository);

  Stream<List<ReplyEntity>> call(ReplyEntity reply) {
    return repository.readReplies(reply);
  }
}
