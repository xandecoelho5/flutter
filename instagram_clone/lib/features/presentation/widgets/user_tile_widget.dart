import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleContainer(
        size: 40,
        child: Helper.profileWidget(
          imageUrl: user.profileUrl,
        ),
      ),
      title: Text(
        user.username!,
        style: primaryBoldStyle,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        PageConst.singleUserProfilePage,
        arguments: user.uid,
      ),
    );
  }
}
