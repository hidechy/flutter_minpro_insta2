import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  ///
  Future<void> setTheme({required bool setDark}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', setDark);
  }
}
