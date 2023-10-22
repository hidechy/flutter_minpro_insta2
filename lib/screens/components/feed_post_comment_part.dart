import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../util/functions.dart';
import 'comment_rich_text.dart';

class FeedPostCommentsPart extends StatelessWidget {
  const FeedPostCommentsPart({super.key, required this.postModel, required this.userModel});

  final PostModel postModel;
  final UserModel userModel;

  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentRichText(
            name: userModel.inAppUserName,
            text: postModel.caption,
          ),
          InkWell(
            child: Text('0 ${S.of(context).comments}'),
          ),
          Text(createTimeAgoString(postModel.postDateTime)),
        ],
      ),
    );
  }
}
