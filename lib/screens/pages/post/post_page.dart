import 'package:flutter/material.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../components/button_with_icon.dart';
import 'post_upload_sub_page.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ButtonWithIcon(
              iconData: Icons.image,
              label: S.of(context).gallery,
              onPressed: () => _openPostUploadScreen(UploadType.gallery, context),
            ),
            const SizedBox(height: 24),
            ButtonWithIcon(
              iconData: Icons.camera,
              label: S.of(context).camera,
              onPressed: () => _openPostUploadScreen(UploadType.camera, context),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _openPostUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostUploadSubPage(uploadType: uploadType)),
    );
  }
}
