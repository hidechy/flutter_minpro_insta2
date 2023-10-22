import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../models/user.dart';
import 'user_card.dart';

class FeedPostHeaderPart extends StatelessWidget {
  const FeedPostHeaderPart({super.key, required this.postUser, required this.post, required this.currentUser});

  final UserModel postUser;
  final PostModel post;
  final UserModel currentUser;

  ///
  @override
  Widget build(BuildContext context) {
    return UserCard(
      photoUrl: postUser.photoUrl,
      title: postUser.inAppUserName,
      subTitle: post.locationString,
    );
  }
}
