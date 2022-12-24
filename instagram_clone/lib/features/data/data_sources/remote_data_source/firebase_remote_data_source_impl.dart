import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/features/data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import 'package:instagram_clone/features/data/models/comment/comment_model.dart';
import 'package:instagram_clone/features/data/models/post/post_model.dart';
import 'package:instagram_clone/features/data/models/reply/reply_model.dart';
import 'package:instagram_clone/features/data/models/user/user_model.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/utils/extensions.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/consts.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
    this.firebaseFirestore,
    this.firebaseAuth,
    this.firebaseStorage,
  );

  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        bio: user.bio,
        following: user.following,
        website: user.website,
        profileUrl: profileUrl,
        username: user.username,
        totalFollowers: user.totalFollowers,
        followers: user.followers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      Helper.toast('Error: $error');
    });
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
        bio: user.bio,
        following: user.following,
        website: user.website,
        profileUrl: user.profileUrl,
        username: user.username,
        totalFollowers: user.totalFollowers,
        followers: user.followers,
        totalFollowing: user.totalFollowing,
        totalPosts: user.totalPosts,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      Helper.toast('Error: $error');
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where('uid', isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map(UserModel.fromSnapshot).toList());
  }

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where('uid', isEqualTo: otherUid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map(UserModel.fromSnapshot).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map(UserModel.fromSnapshot).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty && user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );
      } else {
        Helper.toast('Fields cannot be empty');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Helper.toast('User not found');
      } else if (e.code == 'wrong-password') {
        Helper.toast('Invalid email or password');
      }
    }
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      if (userCredential.user?.uid != null) {
        if (user.imageFile != null) {
          uploadImageToStorage(user.imageFile!, false, 'profileImages').then(
            (profileUrl) => createUserWithImage(user, profileUrl),
          );
        } else {
          await createUserWithImage(user, '');
        }
      }

      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Helper.toast('Email is already taken');
      } else {
        Helper.toast('Something went wrong $e');
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if (user.username.isNotBlank) userInformation['username'] = user.username;

    if (user.name.isNotBlank) userInformation['name'] = user.name;

    if (user.bio.isNotBlank) userInformation['bio'] = user.bio;

    if (user.website.isNotBlank) userInformation['website'] = user.website;

    if (user.profileUrl.isNotBlank) {
      userInformation['profileUrl'] = user.profileUrl;
    }

    if (user.totalFollowing != null) {
      userInformation['totalFollowing'] = user.totalFollowing;
    }

    if (user.totalFollowers != null) {
      userInformation['totalFollowers'] = user.totalFollowers;
    }

    if (user.totalPosts != null) {
      userInformation['totalPosts'] = user.totalPosts;
    }

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> followUnFollowUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final currentDocRef = await userCollection.doc(user.uid).get();
    final otherDocRef = await userCollection.doc(user.otherUid).get();

    if (currentDocRef.exists && otherDocRef.exists) {
      List currentFollowing = currentDocRef.get('following');
      List otherUserFollowers = otherDocRef.get('followers');

      // Current Following List
      if (currentFollowing.contains(user.otherUid)) {
        userCollection.doc(user.uid).update({
          'following': FieldValue.arrayRemove([user.otherUid]),
          'totalFollowing': FieldValue.increment(-1),
        });
      } else {
        userCollection.doc(user.uid).update({
          'following': FieldValue.arrayUnion([user.otherUid]),
          'totalFollowing': FieldValue.increment(1),
        });
      }

      // Other User Followers List
      if (otherUserFollowers.contains(user.uid)) {
        userCollection.doc(user.otherUid).update({
          'followers': FieldValue.arrayRemove([user.uid]),
          'totalFollowers': FieldValue.increment(-1),
        });
      } else {
        userCollection.doc(user.otherUid).update({
          'followers': FieldValue.arrayUnion([user.uid]),
          'totalFollowers': FieldValue.increment(1),
        });
      }
    }
  }

  @override
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  ) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl = await (await uploadTask).ref.getDownloadURL();

    return imageUrl;
  }

  @override
  Future<void> createPost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);

    final newPost = PostModel(
      userProfileUrl: post.userProfileUrl,
      username: post.username,
      totalLikes: 0,
      totalComments: 0,
      imageUrl: post.imageUrl,
      id: post.id,
      likes: const [],
      description: post.description,
      creatorUid: post.creatorUid,
      createdAt: post.createdAt,
    ).toJson();

    try {
      final postDocRef = await postCollection.doc(post.id).get();

      if (!postDocRef.exists) {
        postCollection
            .doc(post.id)
            .set(newPost)
            .then((value) => _updateTotalPostsFromUser(post.creatorUid));
      } else {
        postCollection.doc(post.id).update(newPost);
      }
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> deletePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);

    try {
      postCollection.doc(post.id).delete();
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> likePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);

    final currentUid = await getCurrentUid();
    final postRef = await postCollection.doc(post.id).get();

    if (postRef.exists) {
      final hasLike = (postRef.get('likes') as List).contains(currentUid);
      postCollection.doc(post.id).update({
        'likes': hasLike
            ? FieldValue.arrayRemove([currentUid])
            : FieldValue.arrayUnion([currentUid]),
        'totalLikes': FieldValue.increment(hasLike ? -1 : 1),
      });
    }
  }

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) {
    final postCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .orderBy('createdAt', descending: true);
    return postCollection
        .snapshots()
        .map((qs) => qs.docs.map(PostModel.fromSnapshot).toList());
  }

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) {
    final postCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .where('id', isEqualTo: postId)
        .limit(1);
    return postCollection
        .snapshots()
        .map((qs) => qs.docs.map(PostModel.fromSnapshot).toList());
  }

  @override
  Future<void> updatePost(PostEntity post) async {
    final postCollection = firebaseFirestore.collection(FirebaseConst.posts);
    Map<String, dynamic> postInfo = {};

    if (post.description.isNotBlank) postInfo['description'] = post.description;

    if (post.imageUrl.isNotBlank) postInfo['imageUrl'] = post.imageUrl;

    postCollection.doc(post.id).update(postInfo);
  }

  @override
  Future<void> createComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(comment.postId)
        .collection(FirebaseConst.comment);

    final newComment = CommentModel(
      id: comment.id,
      creatorUid: comment.creatorUid,
      username: comment.username,
      userProfileUrl: comment.userProfileUrl,
      createdAt: comment.createdAt,
      description: comment.description,
      likes: const [],
      postId: comment.postId,
      totalReplies: comment.totalReplies,
    ).toJson();

    try {
      final commentDocRef = await commentCollection.doc(comment.id).get();
      if (!commentDocRef.exists) {
        commentCollection.doc(comment.id).set(newComment).then(
              (value) => _updateTotalCommentsFromPost(comment.postId),
            );
      } else {
        commentCollection.doc(comment.id).update(newComment);
      }
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(comment.postId)
        .collection(FirebaseConst.comment);

    try {
      commentCollection.doc(comment.id).delete().then(
            (value) => _updateTotalCommentsFromPost(comment.postId, -1),
          );
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(comment.postId)
        .collection(FirebaseConst.comment);
    final currentUid = await getCurrentUid();

    final commentRef = await commentCollection.doc(comment.id).get();

    if (commentRef.exists) {
      final hasLike = (commentRef.get('likes') as List).contains(currentUid);
      commentCollection.doc(comment.id).update({
        'likes': hasLike
            ? FieldValue.arrayRemove([currentUid])
            : FieldValue.arrayUnion([currentUid]),
      });
    }
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(postId)
        .collection(FirebaseConst.comment)
        .orderBy('createdAt', descending: true);
    return commentCollection
        .snapshots()
        .map((qs) => qs.docs.map(CommentModel.fromSnapshot).toList());
  }

  @override
  Future<void> updateComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(comment.postId)
        .collection(FirebaseConst.comment);
    Map<String, dynamic> commentInfo = {};

    if (comment.description.isNotBlank) {
      commentInfo['description'] = comment.description;
    }

    commentCollection.doc(comment.id).update(commentInfo);
  }

  @override
  Future<void> createReply(ReplyEntity reply) async {
    final replyCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(reply.postId)
        .collection(FirebaseConst.comment)
        .doc(reply.commentId)
        .collection(FirebaseConst.reply);

    final newReply = ReplyModel(
      id: reply.id,
      creatorUid: reply.creatorUid,
      username: reply.username,
      userProfileUrl: reply.userProfileUrl,
      createdAt: reply.createdAt,
      description: reply.description,
      likes: const [],
      postId: reply.postId,
      commentId: reply.commentId,
    ).toJson();

    try {
      final replyDocRef = await replyCollection.doc(reply.id).get();
      if (!replyDocRef.exists) {
        replyCollection.doc(reply.id).set(newReply).then(
              (value) => _updateTotalRepliesFromComment(
                reply.postId,
                reply.commentId,
              ),
            );
      } else {
        replyCollection.doc(reply.id).update(newReply);
      }
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> deleteReply(ReplyEntity reply) async {
    final replyCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(reply.postId)
        .collection(FirebaseConst.comment)
        .doc(reply.commentId)
        .collection(FirebaseConst.reply);

    try {
      replyCollection.doc(reply.id).delete().then(
            (value) => _updateTotalRepliesFromComment(
              reply.postId,
              reply.commentId,
            ),
          );
    } catch (e) {
      print('some error occured $e');
    }
  }

  @override
  Future<void> likeReply(ReplyEntity reply) async {
    final replyCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(reply.postId)
        .collection(FirebaseConst.comment)
        .doc(reply.commentId)
        .collection(FirebaseConst.reply);
    final currentUid = await getCurrentUid();

    final replyRef = await replyCollection.doc(reply.id).get();

    if (replyRef.exists) {
      final hasLike = (replyRef.get('likes') as List).contains(currentUid);
      replyCollection.doc(reply.id).update({
        'likes': hasLike
            ? FieldValue.arrayRemove([currentUid])
            : FieldValue.arrayUnion([currentUid]),
      });
    }
  }

  @override
  Stream<List<ReplyEntity>> readReplies(ReplyEntity reply) {
    final replyCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(reply.postId)
        .collection(FirebaseConst.comment)
        .doc(reply.commentId)
        .collection(FirebaseConst.reply);

    return replyCollection
        .snapshots()
        .map((qs) => qs.docs.map(ReplyModel.fromSnapshot).toList());
  }

  @override
  Future<void> updateReply(ReplyEntity reply) async {
    final replyCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(reply.postId)
        .collection(FirebaseConst.comment)
        .doc(reply.commentId)
        .collection(FirebaseConst.reply);

    Map<String, dynamic> replyInfo = {};

    if (reply.description.isNotBlank) {
      replyInfo['description'] = reply.description;
    }

    replyCollection.doc(reply.id).update(replyInfo);
  }

  void _updateTotalPostsFromUser(String? uid, [int increment = 1]) {
    final userCollection =
        firebaseFirestore.collection(FirebaseConst.users).doc(uid);
    userCollection.get().then((value) {
      if (value.exists) {
        userCollection.update({
          'totalPosts': FieldValue.increment(increment),
        });
      }
    });
  }

  void _updateTotalCommentsFromPost(String? postId, [int increment = 1]) {
    final postCollection =
        firebaseFirestore.collection(FirebaseConst.posts).doc(postId);
    postCollection.get().then((value) {
      if (value.exists) {
        postCollection.update(
          {'totalComments': FieldValue.increment(increment)},
        );
      }
    });
  }

  void _updateTotalRepliesFromComment(String? postId, String? commentId,
      [int increment = 1]) {
    final commentCollection = firebaseFirestore
        .collection(FirebaseConst.posts)
        .doc(postId)
        .collection(FirebaseConst.comment)
        .doc(commentId);
    commentCollection.get().then((value) {
      if (value.exists) {
        commentCollection.update(
          {'totalReplies': FieldValue.increment(increment)},
        );
      }
    });
  }
}
