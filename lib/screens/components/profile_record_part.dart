import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../viewmodel/profile_viewmodel.dart';

class ProfileRecordPart extends StatelessWidget {
  const ProfileRecordPart({super.key});

  ///
  @override
  Widget build(BuildContext context) {
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
              return _userRecordWidget(title: S.of(context).followers, score: 99);
            }),
        FutureBuilder(
            future: profileViewModel.getNumberOfFollowings(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return _userRecordWidget(title: S.of(context).followings, score: 99);
            }),
      ],
    );
  }

  ///
  Widget _userRecordWidget({required String title, required int score}) {
    return Expanded(
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
    );
  }
}
