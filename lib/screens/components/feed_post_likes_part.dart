import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/like.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../viewmodel/feed_viewmodel.dart';
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

    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder(
        future: feedViewModel.getLikeResult(postId: post.postId),
        builder: (context, AsyncSnapshot<LikeResult> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    (snapshot.data!.isLikeToThisPost)
                        ? IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.yellowAccent),
                            onPressed: () => _unlikeIt(userId: postUser.userId),
                          )
                        : IconButton(icon: const Icon(Icons.favorite_border), onPressed: _likeIt),
                    IconButton(onPressed: _openCommentSubPage, icon: const Icon(Icons.comment)),
                  ],
                ),
                Text('${snapshot.data!.likes.length} ${S.of(context).likes}'),
              ],
            );
          } else {
            return Container();
          }
        },
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

  ///
  Future<void> _likeIt() async {
    final feedViewModel = _context.read<FeedViewModel>();
    await feedViewModel.likeIt(post: post);
  }

  ///
  Future<void> _unlikeIt({required String userId}) async {
    final feedViewModel = _context.read<FeedViewModel>();
    await feedViewModel.unlikeIt(userId: userId, post: post);
  }
}
