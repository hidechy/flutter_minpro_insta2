import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../viewmodel/search_viewmodel.dart';
import 'user_card.dart';

class SearchUserDelegate extends SearchDelegate<UserModel?> {
  ///
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  ///
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  ///
  @override
  Widget buildResults(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    // ignore: cascade_invocations
    searchViewModel.searchUsers(query: query);
    return _buildResults(context: context);
  }

  ///
  @override
  Widget buildSuggestions(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    // ignore: cascade_invocations
    searchViewModel.searchUsers(query: query);
    return _buildResults(context: context);
  }

  ///
  Widget _buildResults({required BuildContext context}) {
    return Consumer<SearchViewModel>(
      builder: (context, model, child) {
        return ListView.builder(
          itemCount: model.soughtUsers.length,
          itemBuilder: (context, index) {
            return UserCard(
              photoUrl: model.soughtUsers[index].photoUrl,
              title: model.soughtUsers[index].inAppUserName,
              subTitle: model.soughtUsers[index].bio,
              onTap: () {
                close(context, model.soughtUsers[index]);
              },
            );
          },
        );
      },
    );
  }
}
