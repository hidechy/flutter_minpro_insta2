import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../enums/constants.dart';
import '../manager/database_manager.dart';
import '../manager/location_manager.dart';
import '../models/comment.dart';
import '../models/location.dart';
import '../models/post.dart';
import '../models/user.dart';

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

  ///
  Future<List<PostModel>> getPosts({required FeedMode feedMode, UserModel? user}) {
    switch (feedMode) {
      case FeedMode.fromFeed:
        return dbManager.getPostMineAndFollowings(userId: user!.userId);

      case FeedMode.fromProfile:
        return dbManager.getPostByUser(userId: user!.userId);
    }
  }

  ///
  Future<void> updatePost(PostModel updatePost) async {
    return dbManager.updatePost(updatePost: updatePost);
  }

  ///
  Future<void> postComment(
      {required PostModel post, required UserModel postUser, required String commentString}) async {
    final comment = CommentModel(
      commentId: const Uuid().v1(),
      postId: post.postId,
      commentUserId: postUser.userId,
      comment: commentString,
      commentDateTime: DateTime.now(),
    );

    await dbManager.postComment(commentModel: comment);
  }

  ///
  Future<List<CommentModel>> getComments({required String postId}) async {
    return dbManager.getComments(postId: postId);
  }

  ///
  Future<void> deleteComment({required String commentId}) async {
    await dbManager.deleteComment(commentId: commentId);
  }
}
