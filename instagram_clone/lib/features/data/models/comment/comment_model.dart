import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    super.id,
    super.postId,
    super.creatorUid,
    super.description,
    super.username,
    super.userProfileUrl,
    super.createdAt,
    super.likes,
    super.totalReplies,
  });

  factory CommentModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return CommentModel(
      id: data['id'],
      postId: data['postId'],
      creatorUid: data['creatorUid'],
      description: data['description'],
      username: data['username'],
      userProfileUrl: data['userProfileUrl'],
      createdAt: data['createdAt'],
      likes: List.from(data['likes']),
      totalReplies: data['totalReplies'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'creatorUid': creatorUid,
        'description': description,
        'username': username,
        'userProfileUrl': userProfileUrl,
        'createdAt': createdAt,
        'likes': likes,
        'totalReplies': totalReplies,
      };
}
