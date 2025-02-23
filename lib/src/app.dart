// import 'package:flourish/navigation_menu.dart';
// import 'package:flourish/src/features/authentication/screens/onboarding.dart';
// import 'package:flourish/src/utils/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class App extends StatelessWidget {
//   final bool isLoggedIn;
//   const App({super.key, required this.isLoggedIn});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       home: isLoggedIn ? const NavigationMenu() : const OnBoardingScreen(),
//     );
//   }
// }

import 'dart:convert';

import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/features/authentication/screens/chat/message/message.dart';
import 'package:flourish/src/features/authentication/screens/onboarding.dart';
import 'package:flourish/src/features/authentication/screens/product/product_details.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/features/authentication/screens/setting/setting_controller.dart';
import 'package:flourish/src/features/notification/notification_service.dart';
import 'package:flourish/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  final bool isLoggedIn;
  const App({super.key, required this.isLoggedIn});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final details = await _notificationService.notifications
        .getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp ?? false) {
      _handleNotificationPayload(details!.payload);
    }

    // Listen for new notification taps
    _notificationService.notifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (response) {
        _handleNotificationPayload(response.payload);
      },
    );
  }

  // void _handleNotificationPayload(String? payload) {
  //   if (payload == null) return;

  //   final parts = payload.split(':');
  //   final type = parts[0];
  //   final id = parts[1];

  //   if (type == 'chat') {
  //     Get.to(() => MessageScreen(chatId: id));
  //   } else if (type == 'product') {
  //     Get.to(() => ProductDetails(product: id));
  //   }
  // }
  void _handleNotificationPayload(String? payload) {
    if (payload == null) return;

    final parts = payload.split(':');
    final type = parts[0];
    final data = jsonDecode(parts[1]); // Decode the JSON data

    if (type == 'chat') {
      Get.to(() => MessageScreen(
            chatId: data['chatId'],
            otherUserId: data['otherUserId'],
            currentUserName: data['currentUserName'],
          ));
    } else if (type == 'product') {
      // Fetch product details from ID or pass the product object
      Get.to(() => ProductDetails(product: ProductModel.fromJson(data)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.put(SettingsController()).themeMode,
      home:
          widget.isLoggedIn ? const NavigationMenu() : const OnBoardingScreen(),
    );
  }
}

extension on NotificationAppLaunchDetails {
  String? get payload => null;
}
