import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muzik/mocks/mocks.dart';
import 'package:muzik/models/album.dart';
import 'package:muzik/widgets/buttons_row.dart';
import 'package:muzik/widgets/custom_card.dart';
import 'package:muzik/widgets/custom_scaffold.dart';

import '../utils/assets.dart';
import '../widgets/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  _onTapClearSuffix() {
    setState(() => _controller.clear());
  }

  _searchBar() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: SvgPicture.asset(
            Assets.search,
            color: Colors.grey,
            fit: BoxFit.scaleDown,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 50,
            minHeight: 30,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white, width: 0.5),
          ),
          suffixIcon: InkWell(
            onTap: _onTapClearSuffix,
            child: SvgPicture.asset(Assets.close, color: Colors.black),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 45,
            minHeight: 30,
          ),
        ),
        style: TextStyle(color: Colors.grey.shade800),
      ),
    );
  }

  _searchResults() {
    resultTile(Album album) {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CustomCard(
                imageUrl: album.imageUrl,
                width: 90,
                radius: 24,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Album - 2 songs - ${album.releaseYear}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    album.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    album.artist,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const [
                      ButtonsRow(plays: 2, downloads: 1, likes: 2),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: albumsMock.length,
        itemBuilder: (ctx, index) => resultTile(albumsMock[index]),
        separatorBuilder: (ctx, index) => const Divider(
          color: Colors.grey,
          thickness: 0.7,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.build(context),
      child: Column(
        children: [
          _searchBar(),
          _searchResults(),
        ],
      ),
    );
  }
}
