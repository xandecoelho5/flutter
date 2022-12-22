import 'dart:io';

import 'package:instagram_clone/features/domain/repository/firebase_repository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository repository;

  UploadImageToStorageUseCase(this.repository);

  Future<String> call(File file, bool isPost, String childName) async {
    return await repository.uploadImageToStorage(file, isPost, childName);
  }
}
