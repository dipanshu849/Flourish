import "package:flourish/src/utils/theme/theme.dart";
import "package:flutter/material.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
