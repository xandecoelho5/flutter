import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Profile',
        onTap: () => Navigator.pushNamed(context, PageConst.editProfilePage),
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
          '${user.username}',
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
                  const CircleContainer(size: 80),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('${user.totalPosts}', style: primaryBoldStyle),
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
              GridView.builder(
                itemCount: 32,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
