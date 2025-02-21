import 'package:flutter/material.dart';

class ThemeBottomSheet {
  static const BottomSheetThemeData lightBottomSheetTheme =
      BottomSheetThemeData(
          showDragHandle: true,
          backgroundColor: Colors.white,
          modalBackgroundColor: Colors.white,
          constraints: BoxConstraints(minWidth: double.infinity),
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
          )));

  static const BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: Colors.black,
      modalBackgroundColor: Colors.black,
      constraints: BoxConstraints(minWidth: double.infinity),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
      )));
}
