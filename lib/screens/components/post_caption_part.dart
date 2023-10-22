import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/constants.dart';
import '../../viewmodel/post_viewmodel.dart';
import '../pages/post/enlarge_image_sub_page.dart';
import 'hero_image.dart';
import 'post_caption_input_text_field.dart';

// ignore: must_be_immutable
class PostCaptionPart extends StatelessWidget {
  PostCaptionPart({super.key, required this.postCaptionOpenMode});

  final PostCaptionOpenMode postCaptionOpenMode;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final postViewModel = context.read<PostViewModel>();

    final image = (postViewModel.imageFile != null)
        ? Image.file(postViewModel.imageFile!)
        : Image.asset('assets/images/no_image.png');

    switch (postCaptionOpenMode) {
      case PostCaptionOpenMode.fromPost:
        return ListTile(
          leading: HeroImage(
            image: image,
            onTap: () => _displayLargeImage(image: image),
          ),
          title: const PostCaptionInputTextField(),
        );
      case PostCaptionOpenMode.fromFeed:
        return Container();
    }
  }

  ///
  void _displayLargeImage({required Image image}) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => EnlargeImageSubPage(image: image)),
    );
  }
}
