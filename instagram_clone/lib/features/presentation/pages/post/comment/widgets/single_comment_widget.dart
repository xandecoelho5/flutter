import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

import '../../../../../../utils/helper.dart';
import '../../../../widgets/form_container_widget.dart';

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({
    Key? key,
    required this.comment,
    this.onLongPressListener,
    this.onLikeClickListener,
  }) : super(key: key);

  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  String _currentUid = '';
  bool _isUserReplying = false;

  @override
  void initState() {
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then(
          (value) => setState(() => _currentUid = value),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPressListener,
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
                      const Text(
                        'View Replies',
                        style: TextStyle(color: darkGreyColor, fontSize: 12),
                      ),
                    ],
                  ),
                  _isUserReplying ? sizeVer(10) : const SizedBox(),
                  _isUserReplying
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const FormContainerWidget(
                              hintText: 'Post your reply...',
                            ),
                            sizeVer(10),
                            const Text(
                              'Post',
                              style: TextStyle(color: blueColor),
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
