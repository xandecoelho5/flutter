import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

const String userCollection = 'users';
const String postsCollection = 'posts';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  FirebaseService();

  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required File image,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;

      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);

      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection(userCollection).doc(userId).set({
          'name': name,
          'email': email,
          'image': downloadUrl,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = await getUserData(uid: userCredential.user!.uid);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Map> getUserData({required String uid}) async {
    final doc = await _db.collection(userCollection).doc(uid).get();
    return doc.data() as Map;
  }

  Future<bool> postImage(File image) async {
    try {
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage
          .ref('images/${_auth.currentUser!.uid}/$fileName')
          .putFile(image);

      return await task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection(postsCollection).add({
          'userId': _auth.currentUser!.uid,
          'timestamp': Timestamp.now(),
          'image': downloadUrl,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String userId = _auth.currentUser!.uid;
    return _db
        .collection(postsCollection)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(postsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
