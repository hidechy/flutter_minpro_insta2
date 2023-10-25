import 'package:flutter/material.dart';

import '../enums/constants.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({required this.userRepository, required this.postRepository});

  final UserRepository userRepository;
  final PostRepository postRepository;

  late UserModel profileUser;

  UserModel get currentUser => UserRepository.currentUser!;

  bool isProcessing = false;

  List<PostModel> posts = [];

  bool isFollowingProfileUser = false;

  List<UserModel> caresMeUsers = [];

  List<String> stackUserIds = [];

  String psUserId = '';

  WhoCaresMeMode wcmMode = WhoCaresMeMode.like;

  ///
  void setProfileUser({required ProfileMode profileMode, UserModel? selectUser, String? stackUserId}) {
    if (stackUserId != null) {
      stackUserIds.add(stackUserId);
    }

    switch (profileMode) {
      case ProfileMode.myself:
        profileUser = currentUser;
        break;
      case ProfileMode.other:
        profileUser = selectUser!;

        checkIsFollowing();

        break;
    }
  }

  ///
  Future<void> getPost() async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(feedMode: FeedMode.fromProfile, user: profileUser);

    isProcessing = false;
    notifyListeners();
  }

  ///
  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }

  ///
  Future<int> getNumberOfPosts() async {
    posts = await postRepository.getPosts(feedMode: FeedMode.fromProfile, user: profileUser);
    return posts.length;
  }

  ///
  Future<int> getNumberOfFollowers() async {
    return userRepository.getNumberOfFollowers(user: profileUser);
  }

  ///
  Future<int> getNumberOfFollowings() async {
    return userRepository.getNumberOfFollowings(user: profileUser);
  }

  ///
  Future<String> changeProfilePhoto() async {
    final pickedImage = await postRepository.pickImage(UploadType.gallery);
    return (pickedImage != null) ? pickedImage.path : '';
  }

  ///
  Future<void> updateProfile({
    required String name,
    required String bio,
    required String photoUrl,
    required bool isImageFromFile,
  }) async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateProfile(
      profileUser: profileUser,
      name: name,
      bio: bio,
      photoUrl: photoUrl,
      isImageFromFile: isImageFromFile,
    );

    await userRepository.getCurrentUserById(profileUser.userId);

    profileUser = currentUser;

    isProcessing = false;
    notifyListeners();
  }

  ///
  Future<void> follow() async {
    await userRepository.follow(profileUser: profileUser);

    isFollowingProfileUser = true;
    notifyListeners();
  }

  ///
  Future<void> checkIsFollowing() async {
    isFollowingProfileUser = await userRepository.checkIsFollowing(profileUser: profileUser);
    notifyListeners();
  }

  ///
  Future<void> unFollow() async {
    await userRepository.unFollow(profileUser: profileUser);

    isFollowingProfileUser = false;
    notifyListeners();
  }

  ///
  Future<void> getCaresMeUser({
    required WhoCaresMeMode whoCaresMeMode,
    required String postOrUserId,
  }) async {
    wcmMode = whoCaresMeMode;

    caresMeUsers = await userRepository.getCaresMeUser(whoCaresMeMode: whoCaresMeMode, postOrUserId: postOrUserId);

    notifyListeners();
  }

  ///
  Future<void> popStackUserId() async {
    if (stackUserIds.isNotEmpty) {
      psUserId = stackUserIds.last;
      stackUserIds.removeLast();
      profileUser = await userRepository.getUserById(userId: psUserId);
    } else {
      profileUser = currentUser;
    }

    await getPost();
  }

  ///
  void rebuildProfileWhoCareSubPage({required String postOrUserId}) {
    getCaresMeUser(whoCaresMeMode: wcmMode, postOrUserId: postOrUserId);
  }
}
