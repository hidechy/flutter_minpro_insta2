import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
import '../../viewmodel/profile_viewmodel.dart';
import '../pages/profile/profile_who_care_sub_page.dart';

// ignore: must_be_immutable
class ProfileRecordPart extends StatelessWidget {
  ProfileRecordPart({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final profileViewModel = context.read<ProfileViewModel>();

    return Row(
      children: [
        FutureBuilder(
            future: profileViewModel.getNumberOfPosts(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return _userRecordWidget(title: S.of(context).post, score: (snapshot.hasData) ? snapshot.data! : 0);
            }),
        FutureBuilder(
            future: profileViewModel.getNumberOfFollowers(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return _userRecordWidget(
                title: S.of(context).followers,
                score: (snapshot.hasData) ? snapshot.data! : 0,
                whoCaresMeMode: WhoCaresMeMode.followToMe,
              );
            }),
        FutureBuilder(
            future: profileViewModel.getNumberOfFollowings(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return _userRecordWidget(
                title: S.of(context).followings,
                score: (snapshot.hasData) ? snapshot.data! : 0,
                whoCaresMeMode: WhoCaresMeMode.followFromMe,
              );
            }),
      ],
    );
  }

  ///
  Widget _userRecordWidget({required String title, required int score, WhoCaresMeMode? whoCaresMeMode}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (whoCaresMeMode != null) {
            _checkFollowUsers(whoCaresMeMode: whoCaresMeMode);
          }
        },
        child: Column(
          children: [
            Text(
              score.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }

  ///
  void _checkFollowUsers({required WhoCaresMeMode whoCaresMeMode}) {
    final profileViewModel = _context.read<ProfileViewModel>();

    final userId = profileViewModel.profileUser.userId;

    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => ProfileWhoCareSubPage(whoCaresMeMode: whoCaresMeMode, postOrUserId: userId),
      ),
    );
  }
}
