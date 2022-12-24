import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:instagram_clone/features/presentation/widgets/user_tile_widget.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  _noFollowersWidget() {
    return const Center(
      child: Text(
        'No Followers',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Followers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: user.followers!.isEmpty
                  ? _noFollowersWidget()
                  : ListView.builder(
                      itemCount: user.followers!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<List<UserEntity>>(
                          stream: di
                              .sl<GetSingleUserUseCase>()
                              .call(user.followers![index]),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Center(child: Text('No data'));
                            }
                            return UserTileWidget(user: snapshot.data!.first);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
