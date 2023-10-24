import 'package:flutter/material.dart';

import '../models/user.dart';

import '../repository/user_repository.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel({required this.userRepository});

  final UserRepository userRepository;

  List<UserModel> soughtUsers = [];

  ///
  Future<void> searchUsers({required String query}) async {
    soughtUsers = await userRepository.searchUsers(query: query);
    notifyListeners();
  }
}
