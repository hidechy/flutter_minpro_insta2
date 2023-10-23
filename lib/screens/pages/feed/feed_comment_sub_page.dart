import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../components/comment_display_part.dart';
import '../../components/comment_input_part.dart';

class FeedCommentSubPage extends StatelessWidget {
  const FeedCommentSubPage({super.key, required this.post, required this.postUser});

  final PostModel post;
  final UserModel postUser;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),
              CommentInputPart(post: post),
            ],
          ),
        ),
      ),
    );
  }
}
