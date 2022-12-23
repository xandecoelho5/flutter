import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

import '../../../repository/firebase_repository.dart';

class DeleteCommentUseCase {
  final FirebaseRepository repository;

  DeleteCommentUseCase(this.repository);

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}
