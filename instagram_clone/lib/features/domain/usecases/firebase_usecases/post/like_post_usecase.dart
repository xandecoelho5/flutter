import '../../../entities/posts/post_entity.dart';
import '../../../repository/firebase_repository.dart';

class LikePostUseCase {
  final FirebaseRepository repository;

  LikePostUseCase(this.repository);

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}
