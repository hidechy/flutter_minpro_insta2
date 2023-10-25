import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../viewmodel/comment_viewmodel.dart';
import 'comment/comment_display_part.dart';
import 'comment/comment_input_part.dart';
import '../../components/confirm_dialog.dart';

// ignore: must_be_immutable
class FeedCommentSubPage extends StatelessWidget {
  FeedCommentSubPage({super.key, required this.post, required this.postUser});

  final PostModel post;
  final UserModel postUser;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final commentViewModel = context.read<CommentViewModel>();

    Future(() => commentViewModel.getComments(postId: post.postId));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),
              Divider(color: Colors.white.withOpacity(0.5), thickness: 5),
              Consumer<CommentViewModel>(builder: (context, model, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: model.comments.length,
                    itemBuilder: (context, index) {
                      final comment = model.comments[index];

                      final commentUserId = comment.commentUserId;

                      return FutureBuilder(
                        future: model.getCommentUserInfo(userId: commentUserId),
                        builder: (context, AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return CommentDisplayPart(
                              postUserPhotoUrl: snapshot.data!.photoUrl,
                              name: snapshot.data!.inAppUserName,
                              text: comment.comment,
                              postDateTime: comment.commentDateTime,
                              onLongPressed: () {
                                showConfirmDialog(
                                  context: context,
                                  title: S.of(context).deleteComment,
                                  content: S.of(context).deleteCommentConfirm,
                                  onConfirmed: (isConfirmed) {
                                    if (isConfirmed) {
                                      _deleteComment(commentId: comment.commentId);
                                    }
                                  },
                                );
                              },
                            );
                          }

                          return const Center(child: CircularProgressIndicator());
                        },
                      );
                    },
                  ),
                );
              }),
              CommentInputPart(post: post),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _deleteComment({required String commentId}) async {
    final commentViewModel = _context.read<CommentViewModel>();
    await commentViewModel.deleteComment(post: post, commentId: commentId);
  }
}
