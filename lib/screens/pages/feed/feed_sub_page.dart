import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../viewmodel/feed_viewmodel.dart';
import '../../components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  const FeedSubPage({super.key, required this.feedMode});

  final FeedMode feedMode;

  ///
  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    // ignore: cascade_invocations
    feedViewModel.setFeedUser(feedMode: feedMode);

    Future(() => feedViewModel.getPost(feedMode: feedMode));

    return Consumer<FeedViewModel>(builder: (context, model, child) {
      if (model.isProcessing == true) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: model.posts.length,
          itemBuilder: (context, index) {
            return FeedPostTile(feedMode: feedMode, post: model.posts[index]);
          },
        );
      }
    });
  }
}
