import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/location.dart';
import '../../viewmodel/post_viewmodel.dart';

// ignore: must_be_immutable
class PostLocationPart extends StatelessWidget {
  PostLocationPart({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    /// ここはwatch
    final postViewModel = context.watch<PostViewModel>();

    return ListTile(
      title: Text(postViewModel.locationString),
      subtitle: _latLngPart(postViewModel.location),
    );
  }

  ///
  Widget _latLngPart(LocationModel? location) {
    const spaceWidth = 10.0;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Chip(label: Text(S.of(_context).latitude)),
        const SizedBox(width: spaceWidth),
        Text((location != null) ? location.latitude.toStringAsFixed(2) : '0.00'),
        const SizedBox(width: spaceWidth),
        Chip(label: Text(S.of(_context).longitude)),
        const SizedBox(width: spaceWidth),
        Text((location != null) ? location.longitude.toStringAsFixed(2) : '0.00'),
      ],
    );
  }
}
