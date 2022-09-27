import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muzik/utils/assets.dart';
import 'package:muzik/widgets/custom_scaffold.dart';
import 'package:muzik/widgets/music_player.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_card.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  _albumTile() {
    return IntrinsicHeight(
      child: Row(
        children: [
          const CustomCard(
            imageUrl: Assets.home1,
            width: 140,
            radius: 24,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Album - 2 songs - 2021',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Satisfied',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mercy Chinwo',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SvgPicture.asset(Assets.heartOutlined),
                    const SizedBox(width: 24),
                    SvgPicture.asset(Assets.downloadOutlined),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _songsList() {
    final songs = [
      'Chinedum',
      'No More Pain',
      'Oh Jesus',
      'Baby Song',
      'Udeme',
      'Tasted of Your Dreams',
      'Obinasom',
      'Adaksodask askdoask',
      'Supimpaa',
    ];

    songTile(String title, int index) {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                if (index == 2)
                  Image.asset(
                    Assets.musicLevel,
                    height: 40,
                    width: 30,
                  )
                else
                  Text(
                    '0${index + 1}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        'Mercy Chinwo',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                SvgPicture.asset(Assets.heartOutlined),
                const SizedBox(width: 24),
                SvgPicture.asset(Assets.downloadOutlined),
              ],
            ),
          ),
        ],
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
          right: 32,
          left: 12,
        ),
        itemCount: songs.length,
        itemBuilder: (ctx, index) => songTile(songs[index], index),
        separatorBuilder: (ctx, index) => const SizedBox(height: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.build(context),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    _albumTile(),
                    _songsList(),
                  ],
                ),
              ),
            ),
            const MusicPlayer(),
          ],
        ),
      ),
    );
  }
}
