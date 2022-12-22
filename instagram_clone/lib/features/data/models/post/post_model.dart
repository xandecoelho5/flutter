import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    super.id,
    super.creatorUid,
    super.username,
    super.description,
    super.imageUrl,
    super.likes,
    super.totalLikes,
    super.totalComments,
    super.createdAt,
    super.userProfileUrl,
  });

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return PostModel(
      id: data['id'],
      creatorUid: data['creatorUid'],
      username: data['username'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      likes: List.from(data['likes']),
      totalLikes: data['totalLikes'],
      totalComments: data['totalComments'],
      createdAt: data['createdAt'],
      userProfileUrl: data['userProfileUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'creatorUid': creatorUid,
        'description': description,
        'userProfileUrl': userProfileUrl,
        'totalLikes': totalLikes,
        'totalComments': totalComments,
        'imageUrl': imageUrl,
        'likes': likes,
        'username': username,
      };
}
