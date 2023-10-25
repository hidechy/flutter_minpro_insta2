import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../components/user_card.dart';

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
}
