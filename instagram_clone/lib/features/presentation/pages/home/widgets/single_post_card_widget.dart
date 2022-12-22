import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/consts.dart';
import '../../../../../utils/helper.dart';
import '../../../widgets/circle_container.dart';

class SinglePostCardWidget extends StatelessWidget {
  const SinglePostCardWidget({Key? key, required this.post}) : super(key: key);

  final PostEntity post;

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Post',
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.updatePostPage,
          arguments: post,
        ),
      ),
      ModalAction(
        title: 'Delete Post',
        onTap: () => BlocProvider.of<PostCubit>(context).deletePost(
          PostEntity(id: post.id),
        ),
      ),
    ]);
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
              Row(
                children: [
                  CircleContainer(
                    size: 30,
                    child: Helper.profileWidget(imageUrl: post.userProfileUrl),
                  ),
                  sizeHor(10),
                  Text('${post.username}', style: primaryBoldStyle),
                ],
              ),
              GestureDetector(
                onTap: () => _openBottomModalSheet(context),
                child: const Icon(Icons.more_vert, color: primaryColor),
              ),
            ],
          ),
          sizeVer(10),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Helper.profileWidget(imageUrl: post.imageUrl),
          ),
          sizeVer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite, color: primaryColor),
                  sizeHor(10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      PageConst.commentPage,
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
          Text('${post.totalLikes} likes', style: primaryBoldStyle),
          sizeVer(6),
          Row(
            children: [
              Text('${post.username}', style: primaryBoldStyle),
              sizeHor(10),
              Text(
                '${post.description}',
                style: const TextStyle(color: primaryColor),
              ),
            ],
          ),
          sizeVer(10),
          Text(
            'View all ${post.totalComments} comments',
            style: const TextStyle(color: darkGreyColor),
          ),
          sizeVer(10),
          Text(
            DateFormat('dd/MMM/yyy').format(post.createdAt!.toDate()),
            style: const TextStyle(color: darkGreyColor),
          ),
        ],
      ),
    );
  }
}
