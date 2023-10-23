import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../util/functions.dart';
import '../../../viewmodel/comment_viewmodel.dart';
import '../../components/circle_photo.dart';
import '../../components/comment_display_part.dart';
import '../../components/comment_input_part.dart';

class FeedCommentSubPage extends StatelessWidget {
  const FeedCommentSubPage({super.key, required this.post, required this.postUser});

  final PostModel post;
  final UserModel postUser;

  ///
  @override
  Widget build(BuildContext context) {
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
                            return ListTile(
                              leading: CirclePhoto(photoUrl: snapshot.data!.photoUrl, isImageFromFile: false),
                              title: Text(snapshot.data!.inAppUserName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(comment.comment),
                                  Text(createTimeAgoString(comment.commentDateTime)),
                                ],
                              ),
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
}
