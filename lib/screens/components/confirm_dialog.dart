import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

// ignore: type_annotate_public_apis, always_declare_return_types
showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  // ignore: strict_raw_type
  required ValueChanged onConfirmed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return ConfirmDialog(title: title, content: content, onConfirmed: onConfirmed);
    },
  );
}

///
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.title, required this.content, required this.onConfirmed});

  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).yes),
          onPressed: () {
            Navigator.pop(context);

            onConfirmed(true);
          },
        ),
        TextButton(
          child: Text(S.of(context).no),
          onPressed: () {
            Navigator.pop(context);

            onConfirmed(false);
          },
        ),
      ],
    );
  }
}
