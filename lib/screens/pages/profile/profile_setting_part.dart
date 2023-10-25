import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enums/constants.dart';
import '../../../generated/l10n.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../../viewmodel/theme_viewmodel.dart';
import '../../login_screen.dart';

// ignore: must_be_immutable
class ProfileSettingPart extends StatelessWidget {
  ProfileSettingPart({super.key, required this.profileMode});

  final ProfileMode profileMode;

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    final themeViewModel = _context.read<ThemeViewModel>();

    return PopupMenuButton(
      icon: const Icon(Icons.settings),
      onSelected: (value) {
        _onPopupMenuSelected(menu: value, isDarkMode: themeViewModel.isDarkMode);
      },
      itemBuilder: (context) {
        switch (profileMode) {
          case ProfileMode.myself:
            return [
              PopupMenuItem(
                value: ProfileSettingMenu.themeChange,
                child: Text(
                  (themeViewModel.isDarkMode) ? S.of(context).changeToLightTheme : S.of(context).changeToDarkTheme,
                ),
              ),
              PopupMenuItem(
                value: ProfileSettingMenu.signOut,
                child: Text(S.of(context).signOut),
              ),
            ];
          case ProfileMode.other:
            return [
              PopupMenuItem(
                value: ProfileSettingMenu.themeChange,
                child: Text(S.of(context).changeToLightTheme),
              ),
            ];
        }
      },
    );
  }

  ///
  void _onPopupMenuSelected({required ProfileSettingMenu menu, required bool isDarkMode}) {
    switch (menu) {
      case ProfileSettingMenu.themeChange:
        final themeViewModel = _context.read<ThemeViewModel>();
        themeViewModel.setTheme(setDark: !isDarkMode);
        break;
      case ProfileSettingMenu.signOut:
        _signOut();
        break;
    }
  }

  ///
  Future<void> _signOut() async {
    final profileViewModel = _context.read<ProfileViewModel>();
    await profileViewModel.signOut();

    // ignore: use_build_context_synchronously
    await Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
