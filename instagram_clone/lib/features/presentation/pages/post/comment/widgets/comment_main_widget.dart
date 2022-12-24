import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/app_entity.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/post/get_single_post/get_single_post_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/widgets/single_comment_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:uuid/uuid.dart';

class CommentMainWidget extends StatefulWidget {
  const CommentMainWidget({
    Key? key,
    required this.appEntity,
  }) : super(key: key);

  final AppEntity appEntity;

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(
      widget.appEntity.uid!,
    );
    BlocProvider.of<CommentCubit>(context).getComments(
      widget.appEntity.postId!,
    );
    BlocProvider.of<GetSinglePostCubit>(context).getSinglePost(
      widget.appEntity.postId!,
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  _commentSection(UserEntity user) {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleContainer(
            size: 40,
            child: Helper.profileWidget(imageUrl: user.profileUrl),
          ),
          sizeHor(10),
          Expanded(
            child: TextFormField(
              controller: _descriptionController,
              style: const TextStyle(color: primaryColor),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Post your comment...',
                hintStyle: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          TextButton(
            onPressed: () => _createComment(user),
            child: const Text(
              'Post',
              style: TextStyle(color: blueColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  _clear() {
    setState(() {
      _descriptionController.clear();
    });
  }

  _createComment(UserEntity user) {
    BlocProvider.of<CommentCubit>(context)
        .createComment(
          CommentEntity(
            totalReplies: 0,
            id: const Uuid().v1(),
            createdAt: Timestamp.now(),
            description: _descriptionController.text,
            username: user.username,
            userProfileUrl: user.profileUrl,
            creatorUid: user.uid,
            postId: widget.appEntity.postId,
            likes: const [],
          ),
        )
        .then((value) => _clear());
  }

  _deleteComment(String? commentId) {
    BlocProvider.of<CommentCubit>(context)
        .deleteComment(CommentEntity(
          id: commentId,
          postId: widget.appEntity.postId,
        ))
        .then((value) => Navigator.pop(context));
  }

  _likeComment(CommentEntity comment) {
    BlocProvider.of<CommentCubit>(context).likeComment(comment);
  }

  _openBottomModalSheet(BuildContext context, CommentEntity comment) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Update Comment',
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.updateCommentPage,
          arguments: comment,
        ),
      ),
      ModalAction(
        title: 'Delete Comment',
        onTap: () => _deleteComment(comment.id),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Comments'),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final user = singleUserState.user;
            return BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
              builder: (context, singlePostState) {
                if (singlePostState is GetSinglePostLoaded) {
                  final post = singlePostState.post;
                  return BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, commentState) {
                      if (commentState is CommentLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  CircleContainer(
                                    size: 40,
                                    child: Helper.profileWidget(
                                      imageUrl: post.userProfileUrl,
                                    ),
                                  ),
                                  sizeHor(10),
                                  Text(
                                    '${post.username}',
                                    style: primaryBoldStyle.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            sizeVer(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                '${post.description}',
                                style: const TextStyle(color: primaryColor),
                              ),
                            ),
                            sizeVer(10),
                            const Divider(color: secondaryColor),
                            sizeVer(10),
                            Expanded(
                              child: ListView.builder(
                                itemCount: commentState.comments.length,
                                itemBuilder: (context, index) {
                                  final comment = commentState.comments[index];
                                  return SingleCommentWidget(
                                    comment: comment,
                                    onLongPressListener: () =>
                                        _openBottomModalSheet(
                                      context,
                                      comment,
                                    ),
                                    onLikeClickListener: () =>
                                        _likeComment(comment),
                                    user: user,
                                  );
                                },
                              ),
                            ),
                            _commentSection(user),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
