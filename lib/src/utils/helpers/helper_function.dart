import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperFunction {
  static void showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  static bool isDarkMode() {
    return Get.isDarkMode;
  }
}
