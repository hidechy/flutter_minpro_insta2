import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/constants.dart';
import '../../generated/l10n.dart';
import '../../viewmodel/profile_viewmodel.dart';
import '../pages/profile/profile_edit_page.dart';

// ignore: must_be_immutable
class ProfileBioPart extends StatelessWidget {
  ProfileBioPart({super.key, required this.profileMode});

  final ProfileMode profileMode;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final profileViewModel = context.read<ProfileViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(profileViewModel.profileUser.inAppUserName),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _openProfileEditPage,
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            child: Text((profileMode == ProfileMode.myself) ? S.of(context).editProfile : 'フォローする'),
          ),
        ),
      ],
    );
  }

  ///
  void _openProfileEditPage() {
    Navigator.push(_context, MaterialPageRoute(builder: (context) => const ProfileEditPage()));
  }
}
