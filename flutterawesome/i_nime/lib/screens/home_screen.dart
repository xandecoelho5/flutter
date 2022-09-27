import 'package:flutter/material.dart';
import 'package:i_nime/main.dart';
import 'package:i_nime/repositories/anime_repository.dart';
import 'package:i_nime/screens/search_screen.dart';

import '../models/anime.dart';
import '../widgets/anime_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Anime> trendingAnimes = [];
  late double _deviceHeight;

  @override
  initState() {
    super.initState();
    _fetchTrendingAnimes();
  }

  void _fetchTrendingAnimes() async {
    trendingAnimes = await getIt.get<IAnimeRepository>().getTrendingAnimes();
    setState(() {});
  }

  _animesList() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: trendingAnimes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: _deviceHeight * 0.32,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return AnimeCard(anime: trendingAnimes[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'INime',
          style: TextStyle(fontFamily: 'RubikDirt'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Trending',
              style: TextStyle(fontFamily: 'RubikDirt', fontSize: 32),
            ),
          ),
          SizedBox(height: _deviceHeight * 0.02),
          _animesList(),
        ],
      ),
    );
  }
}
