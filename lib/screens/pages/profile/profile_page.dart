import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../models/user.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../components/profile_detail_part.dart';
import '../../components/profile_post_grid_part.dart';
import '../../components/profile_setting_part.dart';

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
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(model.profileUser.inAppUserName),
                  pinned: true,
                  floating: true,
                  expandedHeight: 280,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ProfileDetailPart(profileMode: profileMode),
                  ),
                  actions: [
                    ProfileSettingPart(profileMode: profileMode),
                  ],
                ),
                ProfilePostGridPart(posts: model.posts),
              ],
            );
          },
        ),
      ),
    );
  }
}
