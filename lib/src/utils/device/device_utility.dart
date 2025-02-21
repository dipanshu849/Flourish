import 'dart:io';

import 'package:flutter/material.dart';

class DeviceUtility {
  /// Returns the device's screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Returns the device's screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Returns the device's screen orientation
  static Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Returns the device's platform (iOS or Android)
  static TargetPlatform getPlatform() {
    if (Platform.isIOS) {
      return TargetPlatform.iOS;
    } else {
      return TargetPlatform.android;
    }
  }
}
