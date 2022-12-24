import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class SingleUserProfileMainWidget extends StatefulWidget {
  const SingleUserProfileMainWidget({Key? key, required this.otherUserId})
      : super(key: key);

  final String otherUserId;

  @override
  State<SingleUserProfileMainWidget> createState() =>
      _SingleUserProfileMainWidgetState();
}

class _SingleUserProfileMainWidgetState
    extends State<SingleUserProfileMainWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context)
        .getSingleUser(widget.otherUserId);
    BlocProvider.of<PostCubit>(context).getPosts(const PostEntity());
  }

  _openBottomModalSheet(BuildContext context, UserEntity user) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Profile',
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.editProfilePage,
          arguments: user,
        ),
      ),
      ModalAction(
        title: 'Logout',
        onTap: () {
          BlocProvider.of<AuthCubit>(context).loggedOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageConst.signInPage,
            (route) => false,
          );
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, userState) {
        if (userState is GetSingleUserLoaded) {
          final user = userState.user;
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              title: Text(
                '${user.username}',
                style: const TextStyle(color: primaryColor),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => _openBottomModalSheet(context, user),
                    child: const Icon(Icons.menu, color: primaryColor),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleContainer(
                          size: 80,
                          child:
                              Helper.profileWidget(imageUrl: user.profileUrl),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('${user.totalPosts}',
                                    style: primaryBoldStyle),
                                sizeVer(8),
                                const Text(
                                  'Posts',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                            sizeHor(25),
                            Column(
                              children: [
                                Text(
                                  '${user.totalFollowers}',
                                  style: primaryBoldStyle,
                                ),
                                sizeVer(8),
                                const Text(
                                  'Followers',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                            sizeHor(25),
                            Column(
                              children: [
                                Text(
                                  '${user.totalFollowing}',
                                  style: primaryBoldStyle,
                                ),
                                sizeVer(8),
                                const Text(
                                  'Following',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    sizeVer(10),
                    Text(
                      '${user.name!.isEmpty ? user.username : user.name}',
                      style: primaryBoldStyle,
                    ),
                    sizeVer(10),
                    Text(
                      '${user.bio}',
                      style: const TextStyle(color: primaryColor),
                    ),
                    sizeVer(10),
                    BlocBuilder<PostCubit, PostState>(
                      builder: (context, postState) {
                        if (postState is PostLoaded) {
                          final posts = postState.posts
                              .where((p) => p.creatorUid == user.uid)
                              .toList();
                          return GridView.builder(
                            itemCount: posts.length,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                PageConst.postDetailPage,
                                arguments: posts[index].id,
                              ),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Helper.profileWidget(
                                  imageUrl: posts[index].imageUrl,
                                ),
                              ),
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
