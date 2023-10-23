import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../viewmodel/feed_viewmodel.dart';
import '../pages/post/post_edit_sub_page.dart';
import 'confirm_dialog.dart';
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
        showConfirmDialog(
          context: _context,
          title: S.of(_context).deletePost,
          content: S.of(_context).deletePostConfirm,
          onConfirmed: (isConfirmed) {
            if (isConfirmed) {
              _deletePost(post: post);
            }
          },
        );
        break;
      case PostMenu.share:
        Share.share(post.imageUrl, subject: post.caption);
        break;
    }
  }

  ///
  Future<void> _deletePost({required PostModel post}) async {
    final feedViewModel = _context.read<FeedViewModel>();
    await feedViewModel.deletePost(post: post, feedMode: feedMode);
  }
}
