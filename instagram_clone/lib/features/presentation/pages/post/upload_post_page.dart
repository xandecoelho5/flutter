import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/pages/post/widgets/upload_post_main_widget.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

import '../../cubit/post/post_cubit.dart';

class UploadPostPage extends StatelessWidget {
  const UploadPostPage({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UploadPostMainWidget(user: user),
    );
  }
}
