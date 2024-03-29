import 'dart:io';

import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/repository/firebase_repository.dart';

import '../data_sources/remote_data_source/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) =>
      remoteDataSource.getSingleOtherUser(otherUid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async =>
      remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

  @override
  Future<void> followUnFollowUser(UserEntity user) async =>
      remoteDataSource.followUnFollowUser(user);

  @override
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  ) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);

  @override
  Future<void> createPost(PostEntity post) async =>
      remoteDataSource.createPost(post);

  @override
  Future<void> deletePost(PostEntity post) async =>
      remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async =>
      remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) =>
      remoteDataSource.readPosts(post);

  @override
  Future<void> updatePost(PostEntity post) async =>
      remoteDataSource.updatePost(post);

  @override
  Future<void> createComment(CommentEntity comment) async =>
      remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async =>
      remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async =>
      remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) =>
      remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async =>
      remoteDataSource.updateComment(comment);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) =>
      remoteDataSource.readSinglePost(postId);

  @override
  Future<void> createReply(ReplyEntity reply) async =>
      remoteDataSource.createReply(reply);

  @override
  Future<void> deleteReply(ReplyEntity reply) async =>
      remoteDataSource.deleteReply(reply);

  @override
  Future<void> likeReply(ReplyEntity reply) async =>
      remoteDataSource.likeReply(reply);

  @override
  Stream<List<ReplyEntity>> readReplies(ReplyEntity reply) =>
      remoteDataSource.readReplies(reply);

  @override
  Future<void> updateReply(ReplyEntity reply) async =>
      remoteDataSource.updateReply(reply);
}
