import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

import '../../../repository/firebase_repository.dart';

class UpdateCommentUseCase {
  final FirebaseRepository repository;

  UpdateCommentUseCase(this.repository);

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}
