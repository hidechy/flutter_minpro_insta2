import 'package:flutter/material.dart';

class CommentRichText extends StatefulWidget {
  const CommentRichText({super.key, required this.name, required this.text});

  final String name;
  final String text;

  @override
  State<CommentRichText> createState() => _CommentRichTextState();
}

class _CommentRichTextState extends State<CommentRichText> {
  int _maxLines = 2;

  ///
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _maxLines = 100),
      child: RichText(
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(text: widget.name),
            const TextSpan(text: '：'),
            TextSpan(text: widget.text),
          ],
        ),
      ),
    );
  }
}
