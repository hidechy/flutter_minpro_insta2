import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/comment.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../util/functions.dart';
import '../../../viewmodel/feed_viewmodel.dart';
import 'feed_comment_sub_page.dart';
import 'comment/comment_rich_text.dart';

// ignore: must_be_immutable
class FeedPostCommentsPart extends StatelessWidget {
  FeedPostCommentsPart({super.key, required this.postModel, required this.userModel});

  final PostModel postModel;
  final UserModel userModel;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final feedViewModel = context.read<FeedViewModel>();

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
            onTap: _openCommentSubPage,
            child: FutureBuilder(
              future: feedViewModel.getComments(postId: postModel.postId),
              builder: (context, AsyncSnapshot<List<CommentModel>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Text('${snapshot.data!.length} ${S.of(context).comments}');
                } else {
                  return Container();
                }
              },
            ),
          ),
          Text(createTimeAgoString(postModel.postDateTime)),
        ],
      ),
    );
  }

  ///
  void _openCommentSubPage() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => FeedCommentSubPage(postUser: userModel, post: postModel)),
    );
  }
}
