import 'package:flutter/material.dart';

import '../models/anime.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.anime}) : super(key: key);

  final Anime anime;

  _image() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(anime.synopsisImageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _animeInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            anime.name,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(anime.ageRatingGuide, style: const TextStyle(fontSize: 16)),
              Text(
                anime.type,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  const Icon(Icons.star_border),
                  Text(
                    anime.score,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            anime.synopsis,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _image(),
            _animeInfo(),
          ],
        ),
      ),
    );
  }
}
