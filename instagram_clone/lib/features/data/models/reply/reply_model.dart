import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  const ReplyModel({
    super.id,
    super.creatorUid,
    super.postId,
    super.commentId,
    super.description,
    super.username,
    super.userProfileUrl,
    super.likes,
    super.createdAt,
  });

  factory ReplyModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return ReplyModel(
      id: data['id'],
      creatorUid: data['creatorUid'],
      postId: data['postId'],
      commentId: data['commentId'],
      description: data['description'],
      username: data['username'],
      userProfileUrl: data['userProfileUrl'],
      likes: List.from(data['likes']),
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorUid': creatorUid,
      'postId': postId,
      'commentId': commentId,
      'description': description,
      'username': username,
      'userProfileUrl': userProfileUrl,
      'likes': likes,
      'createdAt': createdAt,
    };
  }
}
