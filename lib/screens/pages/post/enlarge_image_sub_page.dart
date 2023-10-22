import 'package:flutter/material.dart';

import '../../components/hero_image.dart';

class EnlargeImageSubPage extends StatelessWidget {
  const EnlargeImageSubPage({super.key, required this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: HeroImage(
          image: image,
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
