import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

class AppEntity {
  final UserEntity? user;
  final PostEntity? post;

  final String? uid;
  final String? postId;

  const AppEntity({this.user, this.post, this.uid, this.postId});
}
