import 'package:flutter/material.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../pages/post/post_edit_sub_page.dart';
import 'user_card.dart';

// ignore: must_be_immutable
class FeedPostHeaderPart extends StatelessWidget {
  FeedPostHeaderPart(
      {super.key, required this.postUser, required this.post, required this.currentUser, required this.feedMode});

  final UserModel postUser;
  final PostModel post;
  final UserModel currentUser;
  final FeedMode feedMode;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

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
  void _onPopupMenuSelected({required PostMenu selectedMenu}) {
    switch (selectedMenu) {
      case PostMenu.edit:
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => PostEditSubPage(
              post: post,
              postUser: postUser,
              feedMode: feedMode,
            ),
          ),
        );
        break;
      case PostMenu.delete:
        break;
      case PostMenu.share:
        break;
    }
  }
}
