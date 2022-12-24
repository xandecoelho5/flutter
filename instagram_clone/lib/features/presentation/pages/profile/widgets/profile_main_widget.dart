import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class ProfileMainWidget extends StatefulWidget {
  const ProfileMainWidget({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostCubit>(context).getPosts(const PostEntity());
  }

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Profile',
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.editProfilePage,
          arguments: widget.user,
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          '${widget.user.username}',
          style: const TextStyle(color: primaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => _openBottomModalSheet(context),
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
                        Helper.profileWidget(imageUrl: widget.user.profileUrl),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('${widget.user.totalPosts}',
                              style: primaryBoldStyle),
                          sizeVer(8),
                          const Text(
                            'Posts',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          PageConst.followersPage,
                          arguments: widget.user,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${widget.user.totalFollowers}',
                              style: primaryBoldStyle,
                            ),
                            sizeVer(8),
                            const Text(
                              'Followers',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                      sizeHor(25),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          PageConst.followingPage,
                          arguments: widget.user,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${widget.user.totalFollowing}',
                              style: primaryBoldStyle,
                            ),
                            sizeVer(8),
                            const Text(
                              'Following',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              Text(
                '${widget.user.name!.isEmpty ? widget.user.username : widget.user.name}',
                style: primaryBoldStyle,
              ),
              sizeVer(10),
              Text(
                '${widget.user.bio}',
                style: const TextStyle(color: primaryColor),
              ),
              sizeVer(10),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, postState) {
                  if (postState is PostLoaded) {
                    final posts = postState.posts
                        .where((p) => p.creatorUid == widget.user.uid)
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
}
