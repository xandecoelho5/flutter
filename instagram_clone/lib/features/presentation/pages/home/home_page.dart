import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Post',
        onTap: () => Navigator.pushNamed(context, PageConst.updatePostPage),
      ),
      ModalAction(title: 'Delete Post'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.chat, color: primaryColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleContainer(size: 30),
                    sizeHor(10),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
              color: secondaryColor,
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
                      onTap: () =>
                          Navigator.pushNamed(context, PageConst.commentPage),
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
            Text('34 likes', style: primaryBoldStyle),
            sizeVer(6),
            Row(
              children: [
                Text('Username', style: primaryBoldStyle),
                sizeHor(10),
                Text('some description', style: TextStyle(color: primaryColor)),
              ],
            ),
            sizeVer(10),
            Text('View all x comments', style: TextStyle(color: darkGreyColor)),
            sizeVer(10),
            Text('08/05/2022', style: TextStyle(color: darkGreyColor)),
          ],
        ),
      ),
    );
  }
}
