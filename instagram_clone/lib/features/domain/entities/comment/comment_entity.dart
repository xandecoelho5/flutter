import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? id;
  final String? postId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;

  const CommentEntity({
    this.id,
    this.postId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createdAt,
    this.likes,
    this.totalReplies,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        creatorUid,
        description,
        username,
        userProfileUrl,
        createdAt,
        likes,
        totalReplies,
      ];
}
