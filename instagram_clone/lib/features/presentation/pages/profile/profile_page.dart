import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  _openBottomModalSheet(BuildContext context) {
    return Helper.openBottomModalSheet(context, [
      ModalAction(
        title: 'Edit Profile',
        onTap: () => Navigator.pushNamed(context, PageConst.editProfilePage),
      ),
      const ModalAction(title: 'Logout'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Username", style: TextStyle(color: primaryColor)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => _openBottomModalSheet(context),
              child: const Icon(Icons.menu, color: primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("0", style: primaryBoldStyle),
                          sizeVer(8),
                          Text(
                            'Posts',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text("54", style: primaryBoldStyle),
                          sizeVer(8),
                          Text(
                            'Followers',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text("123", style: primaryBoldStyle),
                          sizeVer(8),
                          Text(
                            'Following',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              Text('Name', style: primaryBoldStyle),
              sizeVer(10),
              Text('The bio of user', style: TextStyle(color: primaryColor)),
              sizeVer(10),
              GridView.builder(
                itemCount: 32,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
