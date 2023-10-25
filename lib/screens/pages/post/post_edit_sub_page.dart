import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../viewmodel/feed_viewmodel.dart';
import '../../components/confirm_dialog.dart';
import 'post_caption_part.dart';
import '../../components/user_card.dart';

// ignore: must_be_immutable
class PostEditSubPage extends StatelessWidget {
  PostEditSubPage({super.key, required this.post, required this.postUser, required this.feedMode});

  final PostModel post;
  final UserModel postUser;
  final FeedMode feedMode;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Consumer<FeedViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: (model.isProcessing) ? Text(S.of(context).underProcessing) : Text(S.of(context).editInfo),
            leading: (model.isProcessing)
                ? Container()
                : IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
            actions: [
              (model.isProcessing)
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        showConfirmDialog(
                          context: context,
                          title: S.of(context).editPost,
                          content: S.of(context).editPostConfirm,
                          onConfirmed: (isConfirmed) {
                            if (isConfirmed) {
                              _updatePost();
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.done),
                    ),
            ],
          ),
          body: SafeArea(
            child: (model.isProcessing)
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        UserCard(
                          photoUrl: postUser.photoUrl,
                          title: postUser.inAppUserName,
                          subTitle: post.locationString,
                        ),
                        PostCaptionPart(
                          postCaptionOpenMode: PostCaptionOpenMode.fromFeed,
                          post: post,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  ///
  Future<void> _updatePost() async {
    final feedViewModel = _context.read<FeedViewModel>();
    await feedViewModel.updatePost(post: post, feedMode: feedMode);
    // ignore: use_build_context_synchronously
    Navigator.pop(_context);
  }
}
