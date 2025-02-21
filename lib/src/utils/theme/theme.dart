import 'package:flourish/src/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:flourish/src/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:flourish/src/utils/theme/custom_themes/elevated_btn_theme.dart';
import 'package:flourish/src/utils/theme/custom_themes/outline_btn_theme.dart';
import 'package:flourish/src/utils/theme/custom_themes/text_themes.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThemeText.lightTextTheme,
      bottomSheetTheme: ThemeBottomSheet.lightBottomSheetTheme,
      elevatedButtonTheme: ThemeElevatedButton.lightElevatedButtonTheme,
      outlinedButtonTheme: ThemeOutlineButton.lightOutlineButtonTheme,
      appBarTheme: ThemeAppBar.lightAppBarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: ThemeText.darkTextTheme,
      scaffoldBackgroundColor: Colors.black,
      bottomSheetTheme: ThemeBottomSheet.darkBottomSheetTheme,
      elevatedButtonTheme: ThemeElevatedButton.darkElevatedButtonTheme,
      outlinedButtonTheme: ThemeOutlineButton.darkOutlineButtonTheme,
      appBarTheme: ThemeAppBar.darkAppBarTheme);
}
