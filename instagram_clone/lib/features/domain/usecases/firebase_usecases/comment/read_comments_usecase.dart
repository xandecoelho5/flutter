import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

import '../../../repository/firebase_repository.dart';

class ReadCommentsUseCase {
  final FirebaseRepository repository;

  ReadCommentsUseCase(this.repository);

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}
