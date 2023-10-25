import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/user.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../components/user_card.dart';
import 'profile_sub_page.dart';

// ignore: must_be_immutable
class ProfileWhoCareSubPage extends StatelessWidget {
  ProfileWhoCareSubPage({super.key, required this.whoCaresMeMode, required this.postOrUserId});

  final WhoCaresMeMode whoCaresMeMode;
  final String postOrUserId;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final profileViewModel = context.read<ProfileViewModel>();

    Future(() => profileViewModel.getCaresMeUser(whoCaresMeMode: whoCaresMeMode, postOrUserId: postOrUserId));

    return Scaffold(
      appBar: AppBar(title: Text(_titleText())),
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) {
            return model.caresMeUsers.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: model.caresMeUsers.length,
                    itemBuilder: (context, index) {
                      return UserCard(
                        photoUrl: model.caresMeUsers[index].photoUrl,
                        title: model.caresMeUsers[index].inAppUserName,
                        subTitle: model.caresMeUsers[index].bio,
                        onTap: () {
                          _openProfileScreen(user: model.caresMeUsers[index]);
                        },
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  ///
  String _titleText() {
    switch (whoCaresMeMode) {
      case WhoCaresMeMode.like:
        return S.of(_context).likes;
      case WhoCaresMeMode.followFromMe:
        return S.of(_context).followings;
      case WhoCaresMeMode.followToMe:
        return S.of(_context).followers;
    }
  }

  ///
  void _openProfileScreen({required UserModel user}) {
    final profileViewModel = _context.read<ProfileViewModel>();

    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => ProfileSubPage(
          profileMode: (user.userId == profileViewModel.currentUser.userId) ? ProfileMode.myself : ProfileMode.other,
          selectUser: user,
        ),
      ),
    );
  }
}
