// ignore_for_file: unnecessary_await_in_return

import 'package:flutter/material.dart';

import '../repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.userRepository});

  final UserRepository userRepository;

  ///
  bool isLoading = false;
  bool isSuccessful = false;

  ///
  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }

  ///
  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.signIn();

    isLoading = false;
    notifyListeners();
  }
}
