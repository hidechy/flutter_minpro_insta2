import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../models/user.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import 'profile_detail_part.dart';
import 'profile_post_grid_part.dart';
import 'profile_setting_part.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({
    super.key,
    required this.profileMode,
    this.selectUser,
    required this.isOpenFromProfileScreen,
    this.stackUserId,
  });

  final ProfileMode profileMode;
  final UserModel? selectUser;

  final bool isOpenFromProfileScreen;
  final String? stackUserId;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final profileViewModel = context.read<ProfileViewModel>();

    // ignore: cascade_invocations
    profileViewModel.setProfileUser(
      profileMode: profileMode,
      selectUser: selectUser,
      stackUserId: stackUserId,
    );

    Future(profileViewModel.getPost);

    return Scaffold(
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leadingWidth: (!isOpenFromProfileScreen) ? 0 : 56,
                  leading: (!isOpenFromProfileScreen)
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            model.popStackUserId();

                            _popWithRebuildProfileWhoCareSubPage(postOrUserId: model.psUserId);
                          },
                          icon: const Icon(Icons.ac_unit),
                        ),
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

  ///
  void _popWithRebuildProfileWhoCareSubPage({required String postOrUserId}) {
    final profileViewModel = _context.read<ProfileViewModel>();
    // ignore: cascade_invocations
    profileViewModel.rebuildProfileWhoCareSubPage(postOrUserId: postOrUserId);
    Navigator.pop(_context);
  }
}
