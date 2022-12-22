import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/features/presentation/widgets/form_container_widget.dart';
import 'package:instagram_clone/utils/consts.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool _isUserReplying = false;

  _commentSection() {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CircleContainer(size: 40),
          sizeHor(10),
          Expanded(
            child: TextFormField(
              style: const TextStyle(color: primaryColor),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Post your comment...',
                hintStyle: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          const Text('Post', style: TextStyle(color: blueColor, fontSize: 15)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Comments'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleContainer(size: 40),
                sizeHor(10),
                Text(
                  'Username',
                  style: primaryBoldStyle.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          sizeVer(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'This is verty beautiful place',
              style: TextStyle(color: primaryColor),
            ),
          ),
          sizeVer(10),
          const Divider(color: secondaryColor),
          sizeVer(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleContainer(size: 40),
                sizeHor(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Username',
                            style: primaryBoldStyle.copyWith(fontSize: 15),
                          ),
                          Icon(
                            Icons.favorite_outline,
                            size: 20,
                            color: darkGreyColor,
                          ),
                        ],
                      ),
                      sizeVer(4),
                      Text(
                        'This is a comment',
                        style: TextStyle(color: primaryColor),
                      ),
                      sizeVer(4),
                      Row(
                        children: [
                          Text(
                            '08/08/2021',
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),
                          ),
                          sizeHor(15),
                          GestureDetector(
                            onTap: () => setState(
                              () => _isUserReplying = !_isUserReplying,
                            ),
                            child: Text(
                              'Reply',
                              style: TextStyle(
                                color: darkGreyColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          sizeHor(15),
                          Text(
                            'View Replies',
                            style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),
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
          const Spacer(),
          _commentSection(),
        ],
      ),
    );
  }
}
