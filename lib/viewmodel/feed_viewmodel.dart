import 'package:flutter/material.dart';

import '../enums/constants.dart';
import '../models/comment.dart';
import '../models/like.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class FeedViewModel extends ChangeNotifier {
  FeedViewModel({required this.userRepository, required this.postRepository});

  final UserRepository userRepository;
  final PostRepository postRepository;

  bool isProcessing = false;

  List<PostModel> posts = [];

  late UserModel? feedUser;

  UserModel get currentUser => UserRepository.currentUser!;

  String caption = '';

  ///
  Future<void> getPost({required FeedMode feedMode}) async {
    isProcessing = true;

    notifyListeners();

    posts = await postRepository.getPosts(feedMode: feedMode, user: feedUser);

    isProcessing = false;

    notifyListeners();
  }

  ///
  void setFeedUser({required FeedMode feedMode, UserModel? profileUser}) {
    switch (feedMode) {
      case FeedMode.fromFeed:
        feedUser = currentUser;
        break;
      case FeedMode.fromProfile:
        feedUser = profileUser; //引数
        break;
    }
  }

  ///
  Future<UserModel> getPostUserInfo({required String userId}) async {
    return userRepository.getUserById(userId: userId);
  }

  ///
  Future<void> updatePost({required PostModel post, required FeedMode feedMode}) async {
    isProcessing = true;

    notifyListeners();

    await postRepository.updatePost(post.copyWith(caption: caption));

    await getPost(feedMode: feedMode);

    isProcessing = false;

    notifyListeners();
  }

  ///
  Future<List<CommentModel>> getComments({required String postId}) async {
    return postRepository.getComments(postId: postId);
  }

  ///
  Future<void> likeIt({required PostModel post}) async {
    await postRepository.likeIt(post: post, currentUser: currentUser);
    notifyListeners();
  }

  ///
  Future<LikeResult> getLikeResult({required String postId}) async {
    return postRepository.getLikeResult(postId: postId, currentUser: currentUser);
  }

  ///
  Future<void> unlikeIt({required String userId, required PostModel post}) async {
    await postRepository.unlikeIt(userId: userId, post: post);
    notifyListeners();
  }

  ///
  Future<void> deletePost({required PostModel post, required FeedMode feedMode}) async {
    isProcessing = true;

    notifyListeners();

    await postRepository.deletePost(postId: post.postId, imageStoragePath: post.imageStoragePath);

    await getPost(feedMode: feedMode);

    isProcessing = false;

    notifyListeners();
  }
}
