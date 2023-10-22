import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../viewmodel/post_viewmodel.dart';
import '../../components/confirm_dialog.dart';
import '../../components/post_caption_part.dart';
import '../../components/post_location_part.dart';

// ignore: must_be_immutable
class PostUploadSubPage extends StatelessWidget {
  PostUploadSubPage({super.key, required this.uploadType});

  final UploadType uploadType;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final postViewModel = context.read<PostViewModel>();

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }

    return Consumer<PostViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: (model.isProcessing)
                ? Container()
                : IconButton(
                    onPressed: _cancelPost,
                    icon: const Icon(Icons.arrow_back),
                  ),
            title: (model.isProcessing) ? Text(S.of(context).underProcessing) : Text(S.of(context).post),
            actions: <Widget>[
              (model.isProcessing || !model.isImagePicked)
                  ? IconButton(
                      onPressed: _cancelPost,
                      icon: const Icon(Icons.close),
                    )
                  : IconButton(
                      onPressed: () {
                        showConfirmDialog(
                          context: context,
                          title: S.of(context).post,
                          content: S.of(context).postConfirm,
                          onConfirmed: (isConfirmed) {
                            if (isConfirmed) {
                              _post();
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.done),
                    ),
            ],
          ),
          body: (model.isProcessing)
              ? const Center(child: CircularProgressIndicator())
              : (model.isImagePicked)
                  ? SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            PostCaptionPart(
                              postCaptionOpenMode: PostCaptionOpenMode.fromPost,
                            ),
                            const Divider(),
                            PostLocationPart(),
                            const Divider(),
                          ],
                        ),
                      ),
                    )
                  : Container(),
        );
      },
    );
  }

  ///
  void _cancelPost() {
    _context.read<PostViewModel>().cancelPost();
    Navigator.pop(_context);
  }

  ///
  Future<void> _post() async {
    final postViewModel = _context.read<PostViewModel>();
    await postViewModel.post();

    // ignore: use_build_context_synchronously
    Navigator.pop(_context);
  }
}
