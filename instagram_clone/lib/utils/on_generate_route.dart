import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/app_entity.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/comment_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/edit_comment_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/post_detail_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/update_post_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/edit_profile_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/followers_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/following_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/single_user_profile_page.dart';
import 'package:instagram_clone/utils/consts.dart';

import '../features/domain/entities/comment/comment_entity.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return _routeBuilder(EditProfilePage(user: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.singleUserProfilePage:
        {
          if (args is String) {
            return _routeBuilder(SingleUserProfilePage(userId: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.updatePostPage:
        {
          if (args is PostEntity) {
            return _routeBuilder(UpdatePostPage(post: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.postDetailPage:
        {
          if (args is String) {
            return _routeBuilder(PostDetailPage(postId: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.commentPage:
        {
          if (args is AppEntity) {
            return _routeBuilder(CommentPage(appEntity: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.updateCommentPage:
        {
          if (args is CommentEntity) {
            return _routeBuilder(EditCommentPage(comment: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.signInPage:
        return _routeBuilder(const SignInPage());
      case PageConst.signUpPage:
        return _routeBuilder(const SignUpPage());
      case PageConst.followingPage:
        {
          if (args is UserEntity) {
            return _routeBuilder(FollowingPage(user: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      case PageConst.followersPage:
        {
          if (args is UserEntity) {
            return _routeBuilder(FollowersPage(user: args));
          }
          return _routeBuilder(const NoPageFound());
        }
      default:
        return _routeBuilder(const NoPageFound());
    }
  }

  static dynamic _routeBuilder(Widget child) =>
      MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: const Center(child: Text('Page Not Found')),
    );
  }
}
