import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class EditCommentMainWidget extends StatefulWidget {
  const EditCommentMainWidget({Key? key, required this.comment})
      : super(key: key);

  final CommentEntity comment;

  @override
  State<EditCommentMainWidget> createState() => _EditCommentMainWidgetState();
}

class _EditCommentMainWidgetState extends State<EditCommentMainWidget> {
  late TextEditingController _descriptionController;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
      text: widget.comment.description,
    );
  }

  _editComment() {
    setState(() => _isUpdating = true);
    BlocProvider.of<CommentCubit>(context)
        .updateComment(CommentEntity(
          postId: widget.comment.postId,
          id: widget.comment.id,
          description: _descriptionController.text,
        ))
        .then((value) => _clear());
  }

  void _clear() {
    setState(() {
      _descriptionController.clear();
      _isUpdating = false;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Edit Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ProfileFormWidget(
              controller: _descriptionController,
              title: "Description",
            ),
            sizeVer(10),
            ButtonContainerWidget(
              text: 'Save Changes',
              color: blueColor,
              onTapListener: _editComment,
            ),
            Helper.loadingIndicator(_isUpdating, 'Updating Comment'),
          ],
        ),
      ),
    );
  }
}
