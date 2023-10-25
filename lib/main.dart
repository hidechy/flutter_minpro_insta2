import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// ignore: library_prefixes
import 'package:timeago/timeago.dart' as timeAgo;

import 'di/providers.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'viewmodel/login_viewmodel.dart';
import 'viewmodel/theme_viewmodel.dart';

void main() async {
  timeAgo.setLocaleMessages('ja', timeAgo.JaMessages());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();
    final themeViewModel = context.watch<ThemeViewModel>();

    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: themeViewModel.selectedTheme,
      home: FutureBuilder<bool>(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
