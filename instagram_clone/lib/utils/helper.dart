import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/extensions.dart';

import 'consts.dart';

class ModalAction {
  const ModalAction({required this.title, this.onTap});

  final String title;
  final Function()? onTap;
}

class Helper {
  Helper._();

  static Future<dynamic> openBottomModalSheet(
    BuildContext context,
    List<ModalAction> actions,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          color: backgroundColor.withOpacity(0.8),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'More Options',
                      style: primaryBoldStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  sizeVer(8),
                  const Divider(color: secondaryColor, thickness: 1),
                  sizeVer(8),
                  ...List.generate(
                    actions.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () => actions[index].onTap?.call(),
                            child: Text(
                              actions[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        sizeVer(7),
                        if (index != actions.length - 1)
                          const Divider(color: secondaryColor, thickness: 1),
                        if (index != actions.length - 1) sizeVer(7),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void toast(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: blueColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

  static Widget profileWidget({String? imageUrl, File? image}) {
    if (image == null) {
      if (imageUrl.isBlank) {
        return Image.asset(Assets.profileDefault, fit: BoxFit.cover);
      }
      return CachedNetworkImage(
        imageUrl: '$imageUrl',
        fit: BoxFit.cover,
        progressIndicatorBuilder: (_, u, d) =>
            const CircularProgressIndicator(),
        errorWidget: (_, __, ___) => Image.asset(
          Assets.profileDefault,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.file(image, fit: BoxFit.cover);
  }

  static Widget loadingIndicator(bool isLoading) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please wait...',
              style: TextStyle(color: primaryColor, fontSize: 16),
            ),
            sizeHor(10),
            const CircularProgressIndicator(color: blueColor),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  static Future<File?> selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        Helper.toast('No image selected.');
      }
    } catch (e) {
      Helper.toast('Error selecting image: $e');
    }
    return null;
  }
}
