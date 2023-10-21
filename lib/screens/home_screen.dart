import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'pages/activity/activity_page.dart';
import 'pages/feed/feed_page.dart';
import 'pages/post/post_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/search/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [];
  int _currentIndex = 0;

  ///
  @override
  void initState() {
    _pages = [const FeedPage(), const SearchPage(), const PostPage(), const ActivityPage(), const ProfilePage()];

    super.initState();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem(icon: const Icon(Icons.search), label: S.of(context).search),
          BottomNavigationBarItem(icon: const Icon(Icons.add), label: S.of(context).add),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: S.of(context).activities),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: S.of(context).user),
        ],
      ),
    );
  }
}
