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

  ///
  void setProfileUser({required ProfileMode profileMode, UserModel? selectUser}) {
    switch (profileMode) {
      case ProfileMode.myself:
        profileUser = currentUser;
        break;
      case ProfileMode.other:
        profileUser = selectUser!;
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
    return 0;
  }

  ///
  Future<int> getNumberOfFollowings() async {
    return 0;
  }
}
