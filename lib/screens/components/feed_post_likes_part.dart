import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class FeedPostLikesPart extends StatelessWidget {
  const FeedPostLikesPart({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.comment),
              ),
            ],
          ),
          Text('0 ${S.of(context).likes}'),
        ],
      ),
    );
  }
}
