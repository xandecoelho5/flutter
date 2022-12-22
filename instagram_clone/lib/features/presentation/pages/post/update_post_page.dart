import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/widgets/update_post_main_widget.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({Key? key, required this.post}) : super(key: key);

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UpdatePostMainWidget(post: post),
    );
  }
}
