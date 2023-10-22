import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../viewmodel/feed_viewmodel.dart';

class FeedSubPage extends StatelessWidget {
  const FeedSubPage({super.key, required this.feedMode});

  final FeedMode feedMode;

  ///
  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    /// 名前付き引数にできない
    /// できるならしたい
    // ignore: cascade_invocations
    feedViewModel.setFeedUser(feedMode);

    Future(() => feedViewModel.getPost(feedMode: feedMode));

    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('FeedSubPage'),
          ],
        ),
      ),
    );
  }
}
