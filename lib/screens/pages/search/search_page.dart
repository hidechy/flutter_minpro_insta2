import 'package:flutter/material.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../repository/user_repository.dart';
import '../../components/search_user_delegate.dart';
import '../profile/profile_sub_page.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: InkWell(
          splashColor: Colors.blueGrey,
          onTap: _searchUser,
          child: Text(S.of(context).search),
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Text('SearchPage'),
          ],
        ),
      ),
    );
  }

  ///
  Future<void> _searchUser() async {
    final selectedUser = await showSearch(context: _context, delegate: SearchUserDelegate());

    if (selectedUser != null) {
      // ignore: use_build_context_synchronously
      await Navigator.push(
        _context,
        MaterialPageRoute(
          builder: (context) => ProfileSubPage(
            profileMode: ProfileMode.other,
            selectUser: selectedUser,
            stackUserId: UserRepository.currentUser!.userId,
          ),
        ),
      );
    }
  }
}
