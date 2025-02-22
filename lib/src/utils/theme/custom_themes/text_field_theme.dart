import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

// secondary used here
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: light),
          prefixIconColor: light,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: light)));

// primary used here
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.black),
          prefixIconColor: dark,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.black)));
}
