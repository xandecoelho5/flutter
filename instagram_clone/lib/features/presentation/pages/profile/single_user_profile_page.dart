import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/single_user_profile_main_widget.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

class SingleUserProfilePage extends StatelessWidget {
  const SingleUserProfilePage({Key? key, required this.userId})
      : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: SingleUserProfileMainWidget(otherUserId: userId),
    );
  }
}
