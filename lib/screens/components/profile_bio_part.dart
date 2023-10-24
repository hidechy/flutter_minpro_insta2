import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
import '../../viewmodel/profile_viewmodel.dart';

class ProfileBioPart extends StatelessWidget {
  const ProfileBioPart({super.key, required this.profileMode});

  final ProfileMode profileMode;

  ///
  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(profileViewModel.profileUser.inAppUserName),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            child: Text((profileMode == ProfileMode.myself) ? S.of(context).editProfile : 'フォローする'),
          ),
        ),
      ],
    );
  }
}
