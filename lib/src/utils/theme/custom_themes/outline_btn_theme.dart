import 'package:flutter/material.dart';

class ThemeOutlineButton {
  ThemeOutlineButton._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: Colors.black,
      side: const BorderSide(color: Colors.black),
      padding: const EdgeInsets.symmetric(vertical: 18),
    ),
  );
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 18),
    ),
  );
}
