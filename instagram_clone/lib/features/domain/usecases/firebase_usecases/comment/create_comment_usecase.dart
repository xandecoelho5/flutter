import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

import '../../../repository/firebase_repository.dart';

class CreateCommentUseCase {
  final FirebaseRepository repository;

  CreateCommentUseCase(this.repository);

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}
