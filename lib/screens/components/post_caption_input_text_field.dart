import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../viewmodel/post_viewmodel.dart';

class PostCaptionInputTextField extends StatefulWidget {
  const PostCaptionInputTextField({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostCaptionInputTextFieldState createState() => _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {
  final TextEditingController _captionController = TextEditingController();

  late BuildContext _context;

  ///
  @override
  void initState() {
    _captionController.addListener(_onCaptionUpdated);
    super.initState();
  }

  ///
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return TextField(
      controller: _captionController,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: S.of(context).inputCaption,
        border: InputBorder.none,
      ),
    );
  }

  ///
  void _onCaptionUpdated() {
    final viewModel = _context.read<PostViewModel>();

    // ignore: cascade_invocations
    viewModel.caption = _captionController.text;
    debugPrint('caption: ${viewModel.caption}');
  }
}
