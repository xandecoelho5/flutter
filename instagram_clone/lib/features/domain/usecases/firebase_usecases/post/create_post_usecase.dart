import '../../../entities/posts/post_entity.dart';
import '../../../repository/firebase_repository.dart';

class CreatePostUseCase {
  final FirebaseRepository repository;

  CreatePostUseCase(this.repository);

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}
