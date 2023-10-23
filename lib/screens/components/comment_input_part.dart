import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/post.dart';
import '../../viewmodel/comment_viewmodel.dart';
import 'circle_photo.dart';

class CommentInputPart extends StatefulWidget {
  const CommentInputPart({super.key, required this.post});

  final PostModel post;

  @override
  State<CommentInputPart> createState() => _CommentInputPartState();
}

class _CommentInputPartState extends State<CommentInputPart> {
  TextEditingController commentInputController = TextEditingController();

  bool isCommentPostEnabled = false;

  ///
  @override
  void initState() {
    super.initState();
    commentInputController.addListener(onCommentChanged);
  }

  ///
  @override
  void dispose() {
    commentInputController.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    final commentViewModel = context.watch<CommentViewModel>();
    final commenter = commentViewModel.currentUser;

    return Card(
      color: cardColor,
      child: ListTile(
        leading: CirclePhoto(photoUrl: commenter.photoUrl, isImageFromFile: false),
        title: TextField(
          controller: commentInputController,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            hintText: S.of(context).addComment,
            border: InputBorder.none,
          ),
        ),
        trailing: isCommentPostEnabled
            ? TextButton(
                onPressed: _postComment,
                child: Text(S.of(context).post),
              )
            : null,
      ),
    );
  }

  ///
  void onCommentChanged() {
    final commentViewModel = context.read<CommentViewModel>();
    // ignore: cascade_invocations
    commentViewModel.comment = commentInputController.text;

    setState(() {
      if (commentInputController.text.isNotEmpty) {
        isCommentPostEnabled = true;
      } else {
        isCommentPostEnabled = false;
      }
    });
  }

  ///
  Future<void> _postComment() async {
    final commentViewModel = context.read<CommentViewModel>();
    await commentViewModel.postComment(post: widget.post);
    commentInputController.clear();
  }
}
