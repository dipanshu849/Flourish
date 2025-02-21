import 'package:flutter/material.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

// secondary used here
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.white),
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.white)));

// primary used here
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.black),
          prefixIconColor: Colors.black,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.black)));
}
