import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import '../../../../../utils/consts.dart';

class UploadPostMainWidget extends StatefulWidget {
  const UploadPostMainWidget({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  final _descriptionController = TextEditingController();
  File? _image;
  bool _isUploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _selectImage() async {
    _image = await Helper.selectImage();
    setState(() {});
  }

  _submitPost() {
    setState(() => _isUploading = true);
    di.sl<UploadImageToStorageUseCase>().call(_image!, true, 'posts').then(
      (imageUrl) {
        _createSubmitPost(imageUrl);
      },
    );
  }

  _createSubmitPost(String image) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
          PostEntity(
            description: _descriptionController.text,
            createdAt: Timestamp.now(),
            creatorUid: widget.user.uid,
            id: const Uuid().v1(),
            likes: const [],
            imageUrl: image,
            totalComments: 0,
            totalLikes: 0,
            username: widget.user.username,
            userProfileUrl: widget.user.profileUrl,
          ),
        )
        .then((_) => _clear());
  }

  _clear() {
    setState(() {
      _descriptionController.clear();
      _image = null;
      _isUploading = false;
    });
  }

  Scaffold _uploadPostWidget() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: GestureDetector(
          onTap: _selectImage,
          child: CircleContainer(
            size: 125,
            child: const Center(
              child: Icon(Icons.upload, color: primaryColor, size: 45),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _image == null
        ? _uploadPostWidget()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: IconButton(
                onPressed: () => setState(() => _image = null),
                icon: const Icon(Icons.close, color: primaryColor, size: 28),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _submitPost,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CircleContainer(
                      size: 80,
                      child: Helper.profileWidget(
                        imageUrl: widget.user.profileUrl,
                      ),
                    ),
                    sizeVer(10),
                    Text(
                      '${widget.user.username}',
                      style: const TextStyle(color: primaryColor),
                    ),
                    sizeVer(10),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Helper.profileWidget(image: _image),
                    ),
                    sizeVer(10),
                    ProfileFormWidget(
                      controller: _descriptionController,
                      title: 'Description',
                    ),
                    Helper.loadingIndicator(_isUploading, 'Uploading'),
                  ],
                ),
              ),
            ),
          );
  }
}
