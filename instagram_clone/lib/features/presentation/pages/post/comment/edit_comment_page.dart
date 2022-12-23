import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/widgets/edit_comment_main_widget.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

class EditCommentPage extends StatelessWidget {
  const EditCommentPage({Key? key, required this.comment}) : super(key: key);

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => di.sl<CommentCubit>(),
      child: EditCommentMainWidget(comment: comment),
    );
  }
}
