import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../models/post.dart';
import '../../../viewmodel/post_viewmodel.dart';
import 'enlarge_image_sub_page.dart';
import '../../components/hero_image.dart';
import '../../components/image_from_url.dart';
import 'post_caption_input_text_field.dart';

// ignore: must_be_immutable
class PostCaptionPart extends StatelessWidget {
  PostCaptionPart({super.key, required this.postCaptionOpenMode, this.post});

  final PostCaptionOpenMode postCaptionOpenMode;
  final PostModel? post;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    switch (postCaptionOpenMode) {
      case PostCaptionOpenMode.fromPost:
        final postViewModel = context.read<PostViewModel>();

        final image = (postViewModel.imageFile != null)
            ? Image.file(postViewModel.imageFile!)
            : Image.asset('assets/images/no_image.png');

        return ListTile(
          leading: HeroImage(
            image: image,
            onTap: () => _displayLargeImage(image: image),
          ),
          title: const PostCaptionInputTextField(),
        );
      case PostCaptionOpenMode.fromFeed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ImageFromUrl(imageUrl: post?.imageUrl),
              PostCaptionInputTextField(
                captionBeforeUpdated: post?.caption,
                postCaptionOpenMode: postCaptionOpenMode,
              ),
            ],
          ),
        );
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
