import 'package:flutter/material.dart';

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

  ///
  Future<void> postComment({required PostModel post}) async {
    await postRepository.postComment(post: post, postUser: currentUser, commentString: comment);

    notifyListeners();
  }
}
