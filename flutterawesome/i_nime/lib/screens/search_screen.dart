import 'package:flutter/material.dart';
import 'package:i_nime/repositories/anime_repository.dart';

import '../main.dart';
import '../models/anime.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(color: Colors.white),
  );
  List<Anime> _animesFound = [];
  bool _isLoading = false;

  void onSubmitSearch(String? value) async {
    setState(() => _isLoading = true);
    _animesFound =
        await getIt.get<IAnimeRepository>().getAnimesBySearch(value ?? '');
    setState(() => _isLoading = false);
  }

  AppBar _appBar() {
    return AppBar(
      title: TextField(
        controller: _searchController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          hintText: 'Write anime name',
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          suffixIcon: IconButton(
            onPressed: () => onSubmitSearch(_searchController.text),
            icon: const Icon(Icons.search, color: Colors.black),
          ),
        ),
        onSubmitted: onSubmitSearch,
      ),
    );
  }

  _searchResults() {
    listTile(Anime anime) {
      return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(anime: anime)),
          );
        },
        leading: Image.network(anime.imageUrl),
        title: Text(anime.name),
        subtitle: Row(
          children: [
            const Icon(Icons.star_border),
            Text(anime.score),
          ],
        ),
      );
    }

    if (_animesFound.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.separated(
      itemCount: _animesFound.length,
      itemBuilder: (ctx, index) => listTile(_animesFound[index]),
      separatorBuilder: (ctx, index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults(),
    );
  }
}
