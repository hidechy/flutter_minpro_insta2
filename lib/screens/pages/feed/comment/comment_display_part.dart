import 'package:flutter/material.dart';

import '../../../../util/functions.dart';
import '../../../components/circle_photo.dart';
import 'comment_rich_text.dart';

class CommentDisplayPart extends StatelessWidget {
  const CommentDisplayPart(
      {super.key,
      required this.postUserPhotoUrl,
      required this.name,
      required this.text,
      required this.postDateTime,
      this.onLongPressed});

  final String postUserPhotoUrl;
  final String name;
  final String text;
  final DateTime postDateTime;
  final GestureLongPressCallback? onLongPressed;

  ///
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onLongPress: onLongPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CirclePhoto(photoUrl: postUserPhotoUrl, isImageFromFile: false),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentRichText(name: name, text: text),
                  Text(createTimeAgoString(postDateTime)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
