import 'package:flutter/material.dart';

import '../../../enums/constants.dart';
import '../../../models/user.dart';
import 'profile_page.dart';

class ProfileSubPage extends StatelessWidget {
  const ProfileSubPage({super.key, required this.profileMode, required this.selectUser, required this.stackUserId});

  final ProfileMode profileMode;
  final UserModel selectUser;

  final String stackUserId;

  ///
  @override
  Widget build(BuildContext context) {
    return ProfilePage(
      profileMode: profileMode,
      selectUser: selectUser,
      isOpenFromProfileScreen: true,
      stackUserId: stackUserId,
    );
  }
}
