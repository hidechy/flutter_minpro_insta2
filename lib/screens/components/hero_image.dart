import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key, required this.image, this.onTap});

  final Image image;
  final VoidCallback? onTap;

  ///
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'postImage',
      child: Material(
        color: Colors.white30,
        child: InkWell(onTap: onTap, child: image),
      ),
    );
  }
}
