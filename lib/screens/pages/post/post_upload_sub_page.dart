import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../viewmodel/post_viewmodel.dart';

class PostUploadSubPage extends StatelessWidget {
  const PostUploadSubPage({super.key, required this.uploadType});

  final UploadType uploadType;

  ///
  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }

    return Scaffold(
      body: Container(),
    );
  }
}
