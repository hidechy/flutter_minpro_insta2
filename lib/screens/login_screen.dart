// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../extensions/extensions.dart';
import '../../generated/l10n.dart';
import '../viewmodel/login_viewmodel.dart';
import 'components/button_with_icon.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.screenSize.width,
          child: Consumer<LoginViewModel>(
            builder: (context, viewmodel, child) {
              return viewmodel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).appTitle),
                        const SizedBox(height: 10),
                        ButtonWithIcon(
                          iconData: Icons.login,
                          label: S.of(context).signIn,
                          onPressed: login,
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  ///
  Future<void> login() async {
    final viewModel = _context.read<LoginViewModel>();

    await viewModel.signIn();

    if (!viewModel.isSuccessful) {
      await Fluttertoast.showToast(msg: S.of(_context).signInFailed);
      return;
    }

    _openHomeScreen();
  }

  ///
  void _openHomeScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
