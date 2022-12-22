import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/comment_page.dart';
import 'package:instagram_clone/features/presentation/pages/post/update_post_page.dart';
import 'package:instagram_clone/features/presentation/pages/profile/edit_profile_page.dart';
import 'package:instagram_clone/utils/consts.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.editProfilePage:
        return _routeBuilder(const EditProfilePage());
      case PageConst.updatePostPage:
        return _routeBuilder(const UpdatePostPage());
      case PageConst.commentPage:
        return _routeBuilder(const CommentPage());
      case PageConst.signInPage:
        return _routeBuilder(const SignInPage());
      case PageConst.signUpPage:
        return _routeBuilder(const SignUpPage());
      default:
        {
          const NoPageFound();
        }
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
