import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../enums/constants.dart';
import '../../../models/user.dart';
import '../../../viewmodel/feed_viewmodel.dart';
import '../../components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  const FeedSubPage({super.key, required this.feedMode, this.feedUser, this.index});

  final FeedMode feedMode;
  final UserModel? feedUser;
  final int? index;

  ///
  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    // ignore: cascade_invocations
    feedViewModel.setFeedUser(feedMode: feedMode, profileUser: feedUser);

    Future(() => feedViewModel.getPost(feedMode: feedMode));

    return Consumer<FeedViewModel>(builder: (context, model, child) {
      if (model.isProcessing == true) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return RefreshIndicator(
          onRefresh: () => feedViewModel.getPost(feedMode: feedMode),
          child: ScrollablePositionedList.builder(
            initialScrollIndex: index ?? 0,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: model.posts.length,
            itemBuilder: (context, index) {
              return FeedPostTile(feedMode: feedMode, post: model.posts[index]);
            },
          ),
        );
      }
    });
  }
}
