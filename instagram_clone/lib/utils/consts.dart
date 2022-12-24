import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(0, 0, 0, 1.0);
const blueColor = Color.fromRGBO(0, 149, 246, 1.0);
const primaryColor = Colors.white;
const secondaryColor = Colors.grey;
const darkGreyColor = Color.fromRGBO(97, 97, 97, 1.0);

Widget sizeVer(double height) => SizedBox(height: height);

Widget sizeHor(double width) => SizedBox(width: width);

const primaryBoldStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
);

class PageConst {
  PageConst._();

  static const String home = '/';
  static const String editProfilePage = 'editProfilePage';
  static const String singleUserProfilePage = 'singleUserProfilePage';
  static const String updatePostPage = 'updatePostPage';
  static const String postDetailPage = 'postDetailPage';
  static const String commentPage = 'commentPage';
  static const String updateCommentPage = 'updateCommentPage';
  static const String signInPage = 'signInPage';
  static const String signUpPage = 'signUpPage';
}

class FirebaseConst {
  FirebaseConst._();

  static const String users = 'users';
  static const String posts = 'posts';
  static const String comment = 'comment';
  static const String reply = 'reply';
}

class Assets {
  Assets._();

  static const String profileDefault = 'assets/profile_default.png';
}
