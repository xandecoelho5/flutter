import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/consts.dart';
import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              ),
            ),
            sizeVer(15),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/profile_default.png'),
                  ),
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo, color: blueColor),
                    ),
                  ),
                ],
              ),
            ),
            sizeVer(30),
            FormContainerWidget(
              hintText: 'Username',
            ),
            sizeVer(15),
            FormContainerWidget(
              hintText: 'Email',
            ),
            sizeVer(15),
            FormContainerWidget(
              hintText: 'Password',
              isPasswordField: true,
            ),
            sizeVer(15),
            FormContainerWidget(
              hintText: 'Bio',
            ),
            sizeVer(15),
            ButtonContainerWidget(
              color: blueColor,
              text: 'Sign Up',
              onTapListener: () {},
            ),
            const Spacer(),
            const Divider(color: secondaryColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: primaryColor),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    PageConst.signInPage,
                    (route) => false,
                  ),
                  child: const Text(
                    'Sign In.',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
