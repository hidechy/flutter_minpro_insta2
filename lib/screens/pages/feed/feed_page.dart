import 'package:flutter/material.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../post/post_upload_sub_page.dart';
import 'feed_sub_page.dart';

// ignore: must_be_immutable
class FeedPage extends StatelessWidget {
  FeedPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        leading: IconButton(
          onPressed: _launchCamera,
          icon: const Icon(Icons.camera),
        ),
      ),
      body: const FeedSubPage(feedMode: FeedMode.fromFeed),
    );
  }

  ///
  void _launchCamera() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (_) => PostUploadSubPage(uploadType: UploadType.camera),
      ),
    );
  }
}
