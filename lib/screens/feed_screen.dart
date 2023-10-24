import 'package:flutter/material.dart';

import '../enums/constants.dart';
import '../generated/l10n.dart';
import '../models/user.dart';
import 'pages/feed/feed_sub_page.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key, required this.feedUser, required this.index, required this.feedMode});

  final UserModel feedUser;
  final int index;
  final FeedMode feedMode;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).post)),
      body: FeedSubPage(
        feedMode: feedMode,
        feedUser: feedUser,
        index: index,
      ),
    );
  }
}
