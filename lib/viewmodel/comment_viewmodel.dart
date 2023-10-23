import 'package:flutter/material.dart';

import '../repository/comment_repository.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class CommentViewModel extends ChangeNotifier {
  CommentViewModel({required this.commentRepository, required this.postRepository, required this.userRepository});

  final CommentRepository commentRepository;
  final PostRepository postRepository;
  final UserRepository userRepository;
}
