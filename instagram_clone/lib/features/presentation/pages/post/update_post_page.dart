import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Edit Post'),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.done,
              color: blueColor,
              size: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleContainer(size: 100),
              sizeVer(10),
              Text('Username', style: primaryBoldStyle.copyWith(fontSize: 16)),
              sizeVer(10),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: secondaryColor,
                ),
              ),
              sizeVer(10),
              ProfileFormWidget(title: 'Description'),
            ],
          ),
        ),
      ),
    );
  }
}
