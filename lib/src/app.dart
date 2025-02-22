import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/features/authentication/screens/onboarding.dart';
import 'package:flourish/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: isLoggedIn ? const NavigationMenu() : const OnBoardingScreen(),
    );
  }
}
