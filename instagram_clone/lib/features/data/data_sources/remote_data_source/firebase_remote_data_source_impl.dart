import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/features/data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import 'package:instagram_clone/features/data/models/user/user_model.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/utils/extensions.dart';
import 'package:instagram_clone/utils/helper.dart';

import '../../../../utils/consts.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseRemoteDataSourceImpl(this.firebaseFirestore, this.firebaseAuth);

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
              totalPosts: user.totalPosts)
          .toJson();

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
        await createUser(user);
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
}
