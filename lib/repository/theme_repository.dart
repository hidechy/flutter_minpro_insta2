import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static bool isDarkMode = false;

  ///
  Future<void> setTheme({required bool setDark}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', setDark);
    isDarkMode = setDark;
  }

  ///
  Future<void> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? true;
  }
}
