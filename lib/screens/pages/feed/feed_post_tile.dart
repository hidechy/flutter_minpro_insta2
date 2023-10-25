import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../viewmodel/feed_viewmodel.dart';
import 'feed_post_comment_part.dart';
import 'feed_post_header_part.dart';
import 'feed_post_likes_part.dart';
import '../../components/image_from_url.dart';

class FeedPostTile extends StatelessWidget {
  const FeedPostTile({super.key, required this.feedMode, required this.post});

  final FeedMode feedMode;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: FutureBuilder(
        future: feedViewModel.getPostUserInfo(userId: post.userId),
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final currentUser = feedViewModel.currentUser;

            final postUser = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FeedPostHeaderPart(
                  currentUser: currentUser,
                  postUser: postUser,
                  post: post,
                  feedMode: feedMode,
                ),
                ImageFromUrl(imageUrl: post.imageUrl),
                FeedPostLikesPart(postUser: postUser, post: post),
                FeedPostCommentsPart(userModel: postUser, postModel: post),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
