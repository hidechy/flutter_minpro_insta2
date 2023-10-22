import 'package:flutter/material.dart';

import 'circle_photo.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key, this.onTap, required this.photoUrl, required this.title, required this.subTitle, this.trailing});

  final VoidCallback? onTap;
  final String photoUrl;
  final String title;
  final String subTitle;
  final Widget? trailing;

  ///
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: onTap,
      child: ListTile(
        leading: CirclePhoto(photoUrl: photoUrl, isImageFromFile: false),
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: trailing,
      ),
    );
  }
}
