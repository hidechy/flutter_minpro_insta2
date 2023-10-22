import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CirclePhoto extends StatelessWidget {
  const CirclePhoto({super.key, required this.photoUrl, this.radius, required this.isImageFromFile});

  final String photoUrl;
  final double? radius;
  final bool isImageFromFile;

  ///
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage:
          isImageFromFile ? FileImage(File(photoUrl)) : CachedNetworkImageProvider(photoUrl) as ImageProvider,
    );
  }
}
