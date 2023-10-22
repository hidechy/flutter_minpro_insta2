import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  const ImageFromUrl({super.key, required this.imageUrl});

  final String imageUrl;

  ///
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(imageUrl),
    );
  }
}
