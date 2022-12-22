import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? imageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createdAt;
  final String? userProfileUrl;

  const PostEntity({
    this.id,
    this.creatorUid,
    this.username,
    this.description,
    this.imageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createdAt,
    this.userProfileUrl,
  });

  @override
  List<Object?> get props => [
        id,
        creatorUid,
        username,
        description,
        imageUrl,
        likes,
        totalLikes,
        totalComments,
        createdAt,
        userProfileUrl,
      ];
}
