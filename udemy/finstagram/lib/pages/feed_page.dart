import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FirebaseService? _firebaseService;
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: _deviceHeight!,
      width: _deviceWidth!,
      child: _postsListView(),
    );
  }

  Widget _postsListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getLatestPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List posts = snapshot.data!.docs.map((e) => e.data()).toList();
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              Map post = posts[index];
              return Container(
                height: _deviceHeight! * 0.3,
                margin: EdgeInsets.symmetric(
                  vertical: _deviceHeight! * 0.01,
                  horizontal: _deviceWidth! * 0.05,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(post['image']),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
