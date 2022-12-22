import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/features/presentation/widgets/circle_container.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/helper.dart';
import 'package:instagram_clone/utils/injection_container.dart' as di;

import '../../../cubit/post/post_cubit.dart';

class UpdatePostMainWidget extends StatefulWidget {
  const UpdatePostMainWidget({Key? key, required this.post}) : super(key: key);

  final PostEntity post;

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {
  late TextEditingController _descriptionController;
  File? _image;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
      text: widget.post.description,
    );
  }

  void _selectImage() async {
    _image = await Helper.selectImage();
    setState(() {});
  }

  void _updatePost() {
    setState(() => _isUploading = true);
    if (_image == null) {
      _submitUpdatePost(widget.post.imageUrl!);
    } else {
      di.sl<UploadImageToStorageUseCase>().call(_image!, true, 'posts').then(
            (imageUrl) => _submitUpdatePost(imageUrl),
          );
    }
  }

  void _submitUpdatePost(String image) {
    BlocProvider.of<PostCubit>(context)
        .updatePost(
          PostEntity(
            creatorUid: widget.post.creatorUid,
            id: widget.post.id,
            imageUrl: image,
            description: _descriptionController.text,
          ),
        )
        .then((value) => _clear());
  }

  void _clear() {
    setState(() {
      _descriptionController.clear();
      _isUploading = false;
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Edit Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: _updatePost,
              child: const Icon(
                Icons.done,
                color: blueColor,
                size: 28,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleContainer(
                size: 100,
                child: Helper.profileWidget(
                  imageUrl: widget.post.userProfileUrl,
                ),
              ),
              sizeVer(10),
              Text(
                '${widget.post.username}',
                style: primaryBoldStyle.copyWith(fontSize: 16),
              ),
              sizeVer(10),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Helper.profileWidget(
                      imageUrl: widget.post.imageUrl,
                      image: _image,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: IconButton(
                        onPressed: _selectImage,
                        icon: const Icon(Icons.edit, color: blueColor),
                      ),
                    ),
                  ),
                ],
              ),
              sizeVer(10),
              ProfileFormWidget(
                controller: _descriptionController,
                title: 'Description',
              ),
              Helper.loadingIndicator(_isUploading, 'Updating'),
            ],
          ),
        ),
      ),
    );
  }
}
