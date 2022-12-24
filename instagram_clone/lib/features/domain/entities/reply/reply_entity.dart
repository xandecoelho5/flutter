import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String? id;
  final String? creatorUid;
  final String? postId;
  final String? commentId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final List<String>? likes;
  final Timestamp? createdAt;

  const ReplyEntity({
    this.id,
    this.creatorUid,
    this.postId,
    this.commentId,
    this.description,
    this.username,
    this.userProfileUrl,
    this.likes,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        creatorUid,
        postId,
        commentId,
        description,
        username,
        userProfileUrl,
        likes,
        createdAt,
      ];
}
