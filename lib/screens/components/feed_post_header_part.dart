import 'package:flutter/material.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
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
      trailing: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        onSelected: (PostMenu value) {
          _onPopupMenuSelected(selectedMenu: value);
        },
        itemBuilder: (context) {
          if (postUser.userId == currentUser.userId) {
            return [
              PopupMenuItem(value: PostMenu.edit, child: Text(S.of(context).edit)),
              PopupMenuItem(value: PostMenu.delete, child: Text(S.of(context).delete)),
              PopupMenuItem(value: PostMenu.share, child: Text(S.of(context).share)),
            ];
          } else {
            return [
              PopupMenuItem(value: PostMenu.share, child: Text(S.of(context).share)),
            ];
          }
        },
      ),
    );
  }

  ///
  void _onPopupMenuSelected({required PostMenu selectedMenu}) {}
}
