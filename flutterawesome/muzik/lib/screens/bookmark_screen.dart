import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzik/mocks/mocks.dart';
import 'package:muzik/models/bookmark.dart';

import '../utils/constants.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  AppBar _appBar(context) {
    return AppBar(
      title: const Text(
        'Saved Collection',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          splashRadius: 24,
        ),
      ],
    );
  }

  _bookmarkList() {
    bookmarkTile(Bookmark bookmark) {
      return Row(
        children: [
          Container(
            width: 94,
            height: 94,
            color: const Color(0xFF1B1919),
            child: SvgPicture.asset(
              bookmark.imageUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookmark.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${bookmark.albumQuantity} Album | ${bookmark.songQuantity} Songs',
                  style: const TextStyle(
                    fontSize: 22,
                    color: kOrangeColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: bookmarsMock.length,
      itemBuilder: (ctx, index) => bookmarkTile(bookmarsMock[index]),
      separatorBuilder: (ctx, index) => const SizedBox(height: 36),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bookmarkList(),
    );
  }
}
