import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/reply/reply_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/comment/widgets/single_reply_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import '../../../../../../utils/helper.dart';
import '../../../../widgets/form_container_widget.dart';

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({
    Key? key,
    required this.comment,
    this.onLongPressListener,
    this.onLikeClickListener,
    this.user,
  }) : super(key: key);

  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  final UserEntity? user;

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  final _replyDescriptionController = TextEditingController();
  String _currentUid = '';
  bool _isUserReplying = false;

  @override
  void initState() {
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then(
          (value) => setState(() => _currentUid = value),
        );
  }

  _getReplies() {
    widget.comment.totalReplies == 0
        ? Helper.toast('no replies')
        : BlocProvider.of<ReplyCubit>(context).getReplies(
            ReplyEntity(
              commentId: widget.comment.id,
              postId: widget.comment.postId,
            ),
          );
  }

  _createReply() {
    BlocProvider.of<ReplyCubit>(context)
        .createReply(ReplyEntity(
          id: const Uuid().v1(),
          likes: const [],
          createdAt: Timestamp.now(),
          username: widget.user!.username,
          userProfileUrl: widget.user!.profileUrl,
          creatorUid: widget.user!.uid,
          postId: widget.comment.postId,
          commentId: widget.comment.id,
          description: _replyDescriptionController.text,
        ))
        .then((value) => _clear());
  }

  void _clear() {
    setState(() {
      _replyDescriptionController.clear();
      _isUserReplying = false;
    });
  }

  void _likeReply(ReplyEntity reply) {
    BlocProvider.of<ReplyCubit>(context).likeReply(reply);
  }

  void _deleteReply(ReplyEntity reply) {
    BlocProvider.of<ReplyCubit>(context)
        .deleteReply(reply)
        .then((value) => Navigator.pop(context));
  }

  _openBottomModalSheet(BuildContext context, ReplyEntity reply) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Update Reply',
        // onTap: () => Navigator.pushNamed(
        //   context,
        //   PageConst.updateCommentPage,
        //   arguments: comment,
        // ),
      ),
      ModalAction(
        title: 'Delete Reply',
        onTap: () => _deleteReply(reply),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.comment.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleContainer(
              size: 40,
              child: Helper.profileWidget(
                imageUrl: widget.comment.userProfileUrl,
              ),
            ),
            sizeHor(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.comment.username}',
                        style: primaryBoldStyle.copyWith(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.onLikeClickListener,
                        child: Icon(
                          widget.comment.likes!.contains(_currentUid)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 20,
                          color: widget.comment.likes!.contains(_currentUid)
                              ? Colors.red
                              : darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                  sizeVer(4),
                  Text(
                    '${widget.comment.description}',
                    style: const TextStyle(color: primaryColor),
                  ),
                  sizeVer(4),
                  Row(
                    children: [
                      Text(
                        Helper.formatTimestamp(widget.comment.createdAt!),
                        style: const TextStyle(
                          color: darkGreyColor,
                          fontSize: 12,
                        ),
                      ),
                      sizeHor(15),
                      GestureDetector(
                        onTap: () => setState(
                          () => _isUserReplying = !_isUserReplying,
                        ),
                        child: const Text(
                          'Reply',
                          style: TextStyle(color: darkGreyColor, fontSize: 12),
                        ),
                      ),
                      sizeHor(15),
                      GestureDetector(
                        onTap: _getReplies,
                        child: const Text(
                          'View Replies',
                          style: TextStyle(color: darkGreyColor, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ReplyCubit, ReplyState>(
                    builder: (context, replyState) {
                      if (replyState is ReplyLoaded) {
                        final replies = replyState.replies
                            .where((e) => e.commentId == widget.comment.id)
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: replies.length,
                          itemBuilder: (context, index) => SingleReplyWidget(
                            reply: replies[index],
                            onLongPressListener: () =>
                                _openBottomModalSheet(context, replies[index]),
                            onLikeClickListener: () =>
                                _likeReply(replies[index]),
                          ),
                        );
                      }
                      if (replyState is ReplyLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox();
                    },
                  ),
                  _isUserReplying ? sizeVer(10) : const SizedBox(),
                  _isUserReplying
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FormContainerWidget(
                              controller: _replyDescriptionController,
                              hintText: 'Post your reply...',
                            ),
                            sizeVer(10),
                            TextButton(
                              onPressed: _createReply,
                              child: const Text(
                                'Post',
                                style: TextStyle(color: blueColor),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
