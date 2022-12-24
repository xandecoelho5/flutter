import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

import '../../../../widgets/circle_container.dart';

class SingleReplyWidget extends StatefulWidget {
  const SingleReplyWidget({
    Key? key,
    required this.reply,
    this.onLongPressListener,
    this.onLikeClickListener,
  }) : super(key: key);

  final ReplyEntity reply;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;

  @override
  State<SingleReplyWidget> createState() => _SingleReplyWidgetState();
}

class _SingleReplyWidgetState extends State<SingleReplyWidget> {
  String _currentUid = '';

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
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleContainer(
              size: 40,
              child: Helper.profileWidget(
                imageUrl: widget.reply.userProfileUrl,
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
                        '${widget.reply.username}',
                        style: primaryBoldStyle.copyWith(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.onLikeClickListener,
                        child: Icon(
                          widget.reply.likes!.contains(_currentUid)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 20,
                          color: widget.reply.likes!.contains(_currentUid)
                              ? Colors.red
                              : darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                  sizeVer(4),
                  Text(
                    '${widget.reply.description}',
                    style: const TextStyle(color: primaryColor),
                  ),
                  sizeVer(4),
                  Text(
                    Helper.formatTimestamp(widget.reply.createdAt!),
                    style: const TextStyle(color: darkGreyColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
