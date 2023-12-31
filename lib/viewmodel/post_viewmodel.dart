import 'dart:io';

import 'package:flutter/material.dart';

import '../enums/constants.dart';
import '../models/location.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({required this.userRepository, required this.postRepository});

  final UserRepository userRepository;
  final PostRepository postRepository;

  bool isProcessing = false;
  bool isImagePicked = false;

  File? imageFile;

  LocationModel? location;
  String locationString = '';

  String caption = '';

  ///
  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;

    isProcessing = true;

    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);

    location = await postRepository.getCurrentLocation();
    locationString = (location != null) ? _toLocationString(location!) : '';

    // ignore: unrelated_type_equality_checks
    if (imageFile != '') {
      isImagePicked = true;
    }

    isProcessing = false;

    notifyListeners();
  }

  ///
  String _toLocationString(LocationModel location) {
    final loc = <String>[location.country, location.state, location.city];

    return loc.join(' ');
  }

  ///
  Future<void> updateLocation({required double latitude, required double longitude}) async {
    location = await postRepository.updateLocation(latitude: latitude, longitude: longitude);

    locationString = (location != null) ? _toLocationString(location!) : '';

    notifyListeners();
  }

  ///
  Future<void> post() async {
    if (imageFile == null) {
      return;
    }

    isProcessing = true;
    notifyListeners();

    await postRepository.post(
      user: UserRepository.currentUser!,
      imageFile: imageFile!,
      caption: caption,
      location: location,
      locationString: locationString,
    );

    isProcessing = false;
    isImagePicked = false;

    notifyListeners();
  }

  ///
  void cancelPost() {
    isProcessing = false;
    isImagePicked = false;
    notifyListeners();
  }
}
