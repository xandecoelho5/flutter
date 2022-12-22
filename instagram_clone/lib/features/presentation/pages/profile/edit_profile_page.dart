import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _websiteController;
  late TextEditingController _bioController;

  File? _image;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username);
    _websiteController = TextEditingController(text: widget.user.website);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  void _selectImage() async {
    _image = await Helper.selectImage();
    setState(() {});
  }

  _updateUserProfileData() {
    if (_image == null) {
      _updateUserProfile('');
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(_image!, false, 'profileImages')
          .then((profileUrl) => _updateUserProfile(profileUrl));
    }
  }

  _updateUserProfile(String profileUrl) {
    setState(() => _isUpdating = true);
    BlocProvider.of<UserCubit>(context)
        .updateUser(
      UserEntity(
        uid: widget.user.uid,
        username: _usernameController.text,
        name: _nameController.text,
        website: _websiteController.text,
        bio: _bioController.text,
        profileUrl: profileUrl,
      ),
    )
        .then((_) {
      setState(() => _isUpdating = false);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Edit Profile'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, size: 32),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: _updateUserProfileData,
              child: const Icon(Icons.done, color: blueColor, size: 32),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleContainer(
                  size: 120,
                  child: Helper.profileWidget(
                    imageUrl: widget.user.profileUrl,
                    image: _image,
                  ),
                ),
              ),
              sizeVer(10),
              Center(
                child: TextButton(
                  onPressed: _selectImage,
                  child: const Text(
                    'Change Profile Photo',
                    style: TextStyle(color: blueColor, fontSize: 20),
                  ),
                ),
              ),
              sizeVer(10),
              ProfileFormWidget(controller: _nameController, title: 'Name'),
              sizeVer(15),
              ProfileFormWidget(
                controller: _usernameController,
                title: 'Username',
              ),
              sizeVer(15),
              ProfileFormWidget(
                controller: _websiteController,
                title: 'Website',
              ),
              sizeVer(15),
              ProfileFormWidget(controller: _bioController, title: 'Bio'),
              Helper.loadingIndicator(_isUpdating),
            ],
          ),
        ),
      ),
    );
  }
}
