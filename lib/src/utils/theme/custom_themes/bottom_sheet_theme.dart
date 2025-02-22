import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ThemeBottomSheet {
  static const BottomSheetThemeData lightBottomSheetTheme =
      BottomSheetThemeData(
          showDragHandle: true,
          backgroundColor: light,
          modalBackgroundColor: light,
          constraints: BoxConstraints(minWidth: double.infinity),
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
          )));

  static const BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: dark,
      modalBackgroundColor: dark,
      constraints: BoxConstraints(minWidth: double.infinity),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
      )));
}
