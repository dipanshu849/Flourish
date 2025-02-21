import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ThemeTextBtn {
  static TextButtonThemeData lightTextBtnTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: indigo,
      textStyle: const TextStyle(
        fontSize: base,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static TextButtonThemeData darkTextBtnTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: indigo,
      textStyle: const TextStyle(
        fontSize: base,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
