import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ThemeOutlineButton {
  ThemeOutlineButton._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: dark,
      side: const BorderSide(color: dark),
      padding: const EdgeInsets.symmetric(vertical: 18),
    ),
  );
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: light,
      side: const BorderSide(color: light),
      padding: const EdgeInsets.symmetric(vertical: 18),
    ),
  );
}
