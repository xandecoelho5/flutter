import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final _pages = [const FeedPage(), const ProfilePage()];

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finstagram'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _postImage,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _firebaseService!.logout();
              Navigator.of(context).pushReplacementNamed('login');
            },
          ),
        ],
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (index) => setState(() => _currentPage = index),
      items: const [
        BottomNavigationBarItem(
          label: 'Feed',
          icon: Icon(Icons.feed),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.account_box),
        ),
      ],
    );
  }

  void _postImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    File image = File(result!.files.first.path!);
    await _firebaseService!.postImage(image);
  }
}
