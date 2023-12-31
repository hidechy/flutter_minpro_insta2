import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class CommentViewModel extends ChangeNotifier {
  CommentViewModel({required this.postRepository, required this.userRepository});

  final PostRepository postRepository;
  final UserRepository userRepository;

  UserModel get currentUser => UserRepository.currentUser!;

  String comment = '';

  List<CommentModel> comments = [];

  bool isLoading = false;

  ///
  Future<void> postComment({required PostModel post}) async {
    await postRepository.postComment(post: post, postUser: currentUser, commentString: comment);

    await getComments(postId: post.postId);

    notifyListeners();
  }

  ///
  Future<void> getComments({required String postId}) async {
    isLoading = true;
    notifyListeners();

    comments = await postRepository.getComments(postId: postId);

    isLoading = false;
    notifyListeners();
  }

  ///
  Future<UserModel> getCommentUserInfo({required String userId}) async {
    return userRepository.getUserById(userId: userId);
  }

  ///
  Future<void> deleteComment({required String commentId, required PostModel post}) async {
    await postRepository.deleteComment(commentId: commentId);

    await getComments(postId: post.postId);

    notifyListeners();
  }
}
