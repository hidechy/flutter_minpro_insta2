import 'package:flutter/material.dart';

import '../repository/post_repository.dart';
import '../repository/user_repository.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({required this.userRepository, required this.postRepository});

  final UserRepository userRepository;
  final PostRepository postRepository;

  bool isProcessing = false;
  bool isImagePicked = false;
}
