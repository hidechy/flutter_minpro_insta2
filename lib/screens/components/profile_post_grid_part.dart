import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/constants.dart';
import '../../models/post.dart';
import '../../viewmodel/profile_viewmodel.dart';
import '../feed_screen.dart';
import 'image_from_url.dart';

// ignore: must_be_immutable
class ProfilePostGridPart extends StatelessWidget {
  ProfilePostGridPart({super.key, required this.posts});

  final List<PostModel> posts;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return SliverGrid.count(
      crossAxisCount: 3,
      children: posts.isEmpty
          ? [Container()]
          : List.generate(
              posts.length,
              (index) => InkWell(
                onTap: () => _openFeedScreen(index: index),
                child: ImageFromUrl(imageUrl: posts[index].imageUrl),
              ),
            ),
    );
  }

  ///
  void _openFeedScreen({required int index}) {
    final profileViewModel = _context.read<ProfileViewModel>();

    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => FeedScreen(
          feedUser: profileViewModel.profileUser,
          index: index,
          feedMode: FeedMode.fromProfile,
        ),
      ),
    );
  }
}
