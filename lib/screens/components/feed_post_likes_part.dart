import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../pages/feed/feed_comment_sub_page.dart';

// ignore: must_be_immutable
class FeedPostLikesPart extends StatelessWidget {
  FeedPostLikesPart({super.key, required this.post, required this.postUser});

  final PostModel post;
  final UserModel postUser;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: _openCommentSubPage,
                icon: const Icon(Icons.comment),
              ),
            ],
          ),
          Text('0 ${S.of(context).likes}'),
        ],
      ),
    );
  }

  ///
  void _openCommentSubPage() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => FeedCommentSubPage(postUser: postUser, post: post)),
    );
  }
}
