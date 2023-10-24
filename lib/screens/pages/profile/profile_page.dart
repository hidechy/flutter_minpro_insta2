import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../models/user.dart';
import '../../../viewmodel/profile_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.profileMode, this.selectUser});

  final ProfileMode profileMode;
  final UserModel? selectUser;

  ///
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    // ignore: cascade_invocations
    profileViewModel.setProfileUser(profileMode: profileMode, selectUser: selectUser);

    Future(profileViewModel.getPost);

    return Scaffold(
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                Text(model.posts.length.toString()),
              ],
            );
          },
        ),
      ),
    );
  }
}
