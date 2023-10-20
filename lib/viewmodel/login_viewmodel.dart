import 'package:flutter/material.dart';

import '../repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.userRepository});

  final UserRepository userRepository;

  Future<bool> isSignIn() async {
    // ignore: unnecessary_await_in_return
    return await userRepository.isSignIn();
  }
}
