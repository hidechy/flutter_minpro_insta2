import 'package:flutter/material.dart';

import '../../enums/constants.dart';
import 'profile_bio_part.dart';
import 'profile_image_part.dart';
import 'profile_record_part.dart';

class ProfileDetailPart extends StatelessWidget {
  const ProfileDetailPart({super.key, required this.profileMode});

  final ProfileMode profileMode;

  ///
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: ProfileImagePart()),
              Expanded(flex: 3, child: ProfileRecordPart()),
            ],
          ),
          SizedBox(height: 10),
          ProfileBioPart(),
        ],
      ),
    );
  }
}
