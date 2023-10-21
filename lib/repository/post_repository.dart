import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../enums/constants.dart';
import '../manager/database_manager.dart';
import '../manager/location_manager.dart';
import '../models/location.dart';

class PostRepository {
  PostRepository({required this.dbManager, required this.locationManager});

  final DatabaseManager dbManager;
  final LocationManager locationManager;

  ///
  Future<File?> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    switch (uploadType) {
      case UploadType.gallery:
        final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        return (pickedImage != null) ? File(pickedImage.path) : null;

      case UploadType.camera:
        final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        return (pickedImage != null) ? File(pickedImage.path) : null;
    }
  }

  ///
  Future<LocationModel> getCurrentLocation() async {
    // ignore: unnecessary_await_in_return
    return await locationManager.getCurrentLocation();
  }
}
