import 'dart:io';

import 'package:flutter/material.dart';

import '../enums/constants.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({required this.userRepository, required this.postRepository});

  final UserRepository userRepository;
  final PostRepository postRepository;

  bool isProcessing = false;
  bool isImagePicked = false;

  late File imageFile;

  ///
  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;

    isProcessing = true;

    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);

    debugPrint('pickImages: ${imageFile.path}');

    //TODO　位置情報

    // ignore: unrelated_type_equality_checks
    if (imageFile != '') {
      isImagePicked = true;
    }

    isProcessing = false;

    notifyListeners();
  }
}
