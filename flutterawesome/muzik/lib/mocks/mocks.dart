import 'package:muzik/models/album.dart';
import 'package:muzik/utils/assets.dart';

import '../models/bookmark.dart';

final albumsMock = [
  const Album(
    id: 1,
    name: 'Satisfied',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home1,
    releaseYear: 2021,
  ),
  const Album(
    id: 2,
    name: 'The Cross My Gaze',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home2,
    releaseYear: 2021,
  ),
  const Album(
    id: 3,
    name: 'Yahweh',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home3,
    releaseYear: 2021,
  ),
  const Album(
    id: 4,
    name: 'Onyedikagi',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home4,
    releaseYear: 2021,
  ),
  const Album(
    id: 5,
    name: 'Igwe',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home5,
    releaseYear: 2021,
  ),
  const Album(
    id: 6,
    name: 'Xandzera',
    artist: 'Mercy Chinwo',
    imageUrl: Assets.home6,
    releaseYear: 2021,
  ),
];

final bookmarsMock = [
  const Bookmark(
    id: 1,
    name: 'Gospel',
    imageUrl: Assets.song,
    albumQuantity: 2,
    songQuantity: 7,
  ),
  const Bookmark(
    id: 2,
    name: 'Party Mix',
    imageUrl: Assets.song,
    albumQuantity: 29,
    songQuantity: 227,
  ),
  const Bookmark(
    id: 3,
    name: 'RnB',
    imageUrl: Assets.song,
    albumQuantity: 11,
    songQuantity: 26,
  ),
  const Bookmark(
    id: 4,
    name: 'Afrobeat',
    imageUrl: Assets.song,
    albumQuantity: 30,
    songQuantity: 617,
  ),
  const Bookmark(
    id: 5,
    name: 'My Playlist',
    imageUrl: Assets.song,
    albumQuantity: 8,
    songQuantity: 27,
  ),
  const Bookmark(
    id: 6,
    name: 'Rap de Anime',
    imageUrl: Assets.song,
    albumQuantity: 8,
    songQuantity: 27,
  ),
];
