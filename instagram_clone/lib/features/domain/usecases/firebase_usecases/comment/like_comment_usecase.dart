import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

import '../../../repository/firebase_repository.dart';

class LikeCommentUseCase {
  final FirebaseRepository repository;

  LikeCommentUseCase(this.repository);

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}
