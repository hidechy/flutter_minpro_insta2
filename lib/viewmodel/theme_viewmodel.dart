import 'package:flutter/material.dart';

import '../repository/theme_repository.dart';
import '../util/switch_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel({required this.themeRepository});

  final ThemeRepository themeRepository;

  bool isDarkMode = true;

  ThemeData get selectedTheme => isDarkMode ? darkTheme : lightTheme;

  ///
  Future<void> setTheme({required bool setDark}) async {
    await themeRepository.setTheme(setDark: setDark);
    isDarkMode = setDark;
    notifyListeners();
  }
}
