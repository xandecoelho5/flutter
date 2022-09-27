import 'package:flutter/material.dart';
import 'package:muzik/utils/constants.dart';
import 'package:muzik/widgets/custom_card.dart';
import 'package:muzik/widgets/custom_scaffold.dart';
import 'package:muzik/widgets/music_player.dart';

import '../utils/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedIndex = 0;

  _genres() {
    final genres = ['All', 'Gospel', 'Hip - Hop', 'Pop', 'R&B', 'Rock'];

    genreChip(index) {
      return ChoiceChip(
        label: Text(genres[index]),
        selected: _selectedIndex == index,
        onSelected: (bool selected) {
          setState(() => _selectedIndex = selected ? index : null);
        },
      );
    }

    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 24, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (ctx, index) => genreChip(index),
        separatorBuilder: (ctx, index) => const SizedBox(width: 8),
      ),
    );
  }

  _albums() {
    final albums = [Assets.home1, Assets.home2, Assets.home3];

    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 24, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: albums.length,
        itemBuilder: (ctx, index) => CustomCard(imageUrl: albums[index]),
        separatorBuilder: (ctx, index) => const SizedBox(width: 20),
      ),
    );
  }

  _songs() {
    final songs = [Assets.home4, Assets.home5, Assets.home6];

    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 24, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (ctx, index) => CustomCard(imageUrl: songs[index]),
        separatorBuilder: (ctx, index) => const SizedBox(width: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16),
                child: Text(
                  'DISCOVER',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              _genres(),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text('Trending Albums', style: kHomeTitleStyle),
              ),
              const SizedBox(height: 16.0),
              _albums(),
              const SizedBox(height: 40.0),
              const Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text('Trending Songs', style: kHomeTitleStyle),
              ),
              const SizedBox(height: 16.0),
              _songs(),
            ],
          ),
          const MusicPlayer(),
        ],
      ),
    );
  }
}
