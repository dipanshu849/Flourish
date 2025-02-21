import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ThemeElevatedButton {
  ThemeElevatedButton._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: light,
      backgroundColor: slate800,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: slate800),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: slate400,
      backgroundColor: light,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: slate400),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
  );
}
