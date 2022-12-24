import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/app_entity.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/post/widgets/like_animation_widget.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

import '../../../../../utils/consts.dart';
import '../../../../../utils/helper.dart';
import '../../../widgets/circle_container.dart';

class SinglePostCardWidget extends StatefulWidget {
  const SinglePostCardWidget({Key? key, required this.post}) : super(key: key);

  final PostEntity post;

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  String _currentUid = '';

  bool _isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then(
          (value) => setState(() => _currentUid = value),
        );
  }

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Post',
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.updatePostPage,
          arguments: widget.post,
        ),
      ),
      ModalAction(
        title: 'Delete Post',
        onTap: () => BlocProvider.of<PostCubit>(context).deletePost(
          PostEntity(id: widget.post.id),
        ),
      ),
    ]);
  }

  void _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(
      PostEntity(id: widget.post.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  PageConst.singleUserProfilePage,
                  arguments: widget.post.creatorUid,
                ),
                child: Row(
                  children: [
                    CircleContainer(
                      size: 30,
                      child: Helper.profileWidget(
                        imageUrl: widget.post.userProfileUrl,
                      ),
                    ),
                    sizeHor(10),
                    Text('${widget.post.username}', style: primaryBoldStyle),
                  ],
                ),
              ),
              if (widget.post.creatorUid == _currentUid)
                GestureDetector(
                  onTap: () => _openBottomModalSheet(context),
                  child: const Icon(Icons.more_vert, color: primaryColor),
                ),
            ],
          ),
          sizeVer(10),
          GestureDetector(
            onDoubleTap: () {
              _likePost();
              setState(() => _isLikeAnimating = true);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Helper.profileWidget(imageUrl: widget.post.imageUrl),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isLikeAnimating ? 1 : 0,
                  child: LikeAnimationWidget(
                    duration: const Duration(milliseconds: 300),
                    isLikeAnimating: _isLikeAnimating,
                    onLikeFinish: () =>
                        setState(() => _isLikeAnimating = false),
                    child: const Icon(
                      Icons.favorite,
                      size: 80,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizeVer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _likePost,
                    child: Icon(
                      widget.post.likes!.contains(_currentUid)
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: widget.post.likes!.contains(_currentUid)
                          ? Colors.red
                          : primaryColor,
                    ),
                  ),
                  sizeHor(10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      PageConst.commentPage,
                      arguments: AppEntity(
                        postId: widget.post.id,
                        uid: _currentUid,
                      ),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: primaryColor,
                    ),
                  ),
                  sizeHor(10),
                  const Icon(Icons.send, color: primaryColor),
                ],
              ),
              const Icon(Icons.bookmark_border, color: primaryColor),
            ],
          ),
          sizeVer(10),
          Text('${widget.post.totalLikes} likes', style: primaryBoldStyle),
          sizeVer(6),
          Row(
            children: [
              Text('${widget.post.username}', style: primaryBoldStyle),
              sizeHor(10),
              Text(
                '${widget.post.description}',
                style: const TextStyle(color: primaryColor),
              ),
            ],
          ),
          sizeVer(10),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              PageConst.commentPage,
              arguments: AppEntity(postId: widget.post.id, uid: _currentUid),
            ),
            child: Text(
              'View all ${widget.post.totalComments} comments',
              style: const TextStyle(color: darkGreyColor),
            ),
          ),
          sizeVer(10),
          Text(
            Helper.formatTimestamp(widget.post.createdAt!),
            style: const TextStyle(color: darkGreyColor),
          ),
        ],
      ),
    );
  }
}
