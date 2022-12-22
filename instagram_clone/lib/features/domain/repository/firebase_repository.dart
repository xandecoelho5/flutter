import 'dart:io';

import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

import '../entities/posts/post_entity.dart';

abstract class FirebaseRepository {
  // Credential Features
  Future<void> signInUser(UserEntity user);

  Future<void> signUpUser(UserEntity user);

  Future<bool> isSignIn();

  Future<void> signOut();

  // User Features
  Stream<List<UserEntity>> getUsers(UserEntity user);

  Stream<List<UserEntity>> getSingleUser(String uid);

  Future<String> getCurrentUid();

  Future<void> createUser(UserEntity user);

  Future<void> updateUser(UserEntity user);

  // Cloud Storage Features
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  );

  // Post Features
  Future<void> createPost(PostEntity post);

  Stream<List<PostEntity>> readPosts(PostEntity post);

  Future<void> updatePost(PostEntity post);

  Future<void> deletePost(PostEntity post);

  Future<void> likePost(PostEntity post);
}
