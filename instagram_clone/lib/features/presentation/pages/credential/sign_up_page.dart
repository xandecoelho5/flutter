import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/helper.dart';

import '../../../../utils/consts.dart';
import '../../widgets/button_container_widget.dart';
import '../../widgets/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isSigningUp = false;
  File? _image;

  void _signUpUser() {
    setState(() => _isSigningUp = true);
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          UserEntity(
            email: _emailController.text,
            username: _usernameController.text,
            password: _passwordController.text,
            bio: _bioController.text,
            totalPosts: 0,
            totalFollowers: 0,
            totalFollowing: 0,
            followers: const [],
            following: const [],
            profileUrl: '',
            name: '',
            website: '',
            imageFile: _image,
          ),
        )
        .then((_) => _clear());
  }

  void _selectImage() async {
    _image = await Helper.selectImage();
    setState(() {});
  }

  void _clear() {
    setState(() {
      _emailController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _bioController.clear();
      _isSigningUp = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  SafeArea _bodyWidget() {
    return SafeArea(
      child: Padding(
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
                  CircleContainer(
                    size: 60,
                    child: Helper.profileWidget(image: _image),
                  ),
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: IconButton(
                      onPressed: _selectImage,
                      splashRadius: 15,
                      icon: const Icon(Icons.add_a_photo, color: blueColor),
                    ),
                  ),
                ],
              ),
            ),
            sizeVer(30),
            FormContainerWidget(
              controller: _usernameController,
              hintText: 'Username',
            ),
            sizeVer(15),
            FormContainerWidget(
              controller: _emailController,
              hintText: 'Email',
            ),
            sizeVer(15),
            FormContainerWidget(
              controller: _passwordController,
              hintText: 'Password',
              isPasswordField: true,
            ),
            sizeVer(15),
            FormContainerWidget(
              controller: _bioController,
              hintText: 'Bio',
            ),
            sizeVer(15),
            ButtonContainerWidget(
              color: blueColor,
              text: 'Sign Up',
              onTapListener: _signUpUser,
            ),
            Helper.loadingIndicator(_isSigningUp),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            Helper.toast('Invalid Email and Password');
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                }
                return _bodyWidget();
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }
}
