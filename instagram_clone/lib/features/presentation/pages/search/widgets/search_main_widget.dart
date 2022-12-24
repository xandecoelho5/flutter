import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/search/widgets/search_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/user_tile_widget.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({Key? key}) : super(key: key);

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers(const UserEntity());
    BlocProvider.of<PostCubit>(context).getPosts(const PostEntity());
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              final filterAllUsers = userState.users.where((user) {
                final username = user.username!.toLowerCase();
                final text = _searchController.text.toLowerCase();
                return username.startsWith(text) || username.contains(text);
              }).toList();
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchWidget(controller: _searchController),
                    sizeVer(10),
                    _searchController.text.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: filterAllUsers.length,
                              itemBuilder: (context, index) =>
                                  UserTileWidget(user: filterAllUsers[index]),
                            ),
                          )
                        : BlocBuilder<PostCubit, PostState>(
                            builder: (context, postState) {
                              if (postState is PostLoaded) {
                                return Expanded(
                                  child: GridView.builder(
                                    itemCount: postState.posts.length,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        PageConst.postDetailPage,
                                        arguments: postState.posts[index].id,
                                      ),
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Helper.profileWidget(
                                          imageUrl:
                                              postState.posts[index].imageUrl,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
