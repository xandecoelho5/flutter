import '../../../entities/posts/post_entity.dart';
import '../../../repository/firebase_repository.dart';

class ReadPostsUseCase {
  final FirebaseRepository repository;

  ReadPostsUseCase(this.repository);

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}
