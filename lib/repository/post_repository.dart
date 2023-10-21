import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../enums/constants.dart';

class PostRepository {
  ///
  dynamic pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    switch (uploadType) {
      case UploadType.gallery:
        final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        return (pickedImage != null) ? File(pickedImage.path) : '';

      case UploadType.camera:
        final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        return (pickedImage != null) ? File(pickedImage.path) : '';
    }
  }
}
