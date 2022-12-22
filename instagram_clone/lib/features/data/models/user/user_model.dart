import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.username,
    super.name,
    super.bio,
    super.website,
    super.email,
    super.profileUrl,
    super.followers,
    super.following,
    super.totalFollowers,
    super.totalFollowing,
    super.totalPosts,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      website: snapshot['website'],
      email: snapshot['email'],
      profileUrl: snapshot['profileUrl'],
      followers: List.from(snapshot['followers']),
      following: List.from(snapshot['following']),
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'name': name,
        'bio': bio,
        'website': website,
        'email': email,
        'profileUrl': profileUrl,
        'followers': followers,
        'following': following,
        'totalFollowers': totalFollowers,
        'totalFollowing': totalFollowing,
        'totalPosts': totalPosts,
      };
}
