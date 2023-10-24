import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/profile_viewmodel.dart';
import 'circle_photo.dart';

class ProfileImagePart extends StatelessWidget {
  const ProfileImagePart({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return CirclePhoto(
      photoUrl: profileViewModel.currentUser.photoUrl,
      isImageFromFile: false,
      radius: 30,
    );
  }
}
