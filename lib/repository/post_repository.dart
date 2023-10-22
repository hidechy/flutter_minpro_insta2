import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:test_minpro_insta_clone/models/post.dart';
import 'package:test_minpro_insta_clone/models/user.dart';
import 'package:uuid/uuid.dart';

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

  ///
  Future<LocationModel> updateLocation({required double latitude, required double longitude}) async {
    return locationManager.updateLocation(latitude: latitude, longitude: longitude);
  }

  ///
  Future<void> post(
      {required UserModel user,
      required File imageFile,
      required String caption,
      LocationModel? location,
      required String locationString}) async {
    final storageId = const Uuid().v1();
    final imageUrl = await dbManager.uploadImageToStorage(imageFile: imageFile, storageId: storageId);
    //debugPrint('storageImageUrl : $imageUrl');

    final post = PostModel(
      postId: const Uuid().v1(),
      userId: user.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: (location != null) ? location.latitude : 0,
      longitude: (location != null) ? location.longitude : 0,
      postDateTime: DateTime.now(),
    );

    await dbManager.insertPost(post);
  }
}
