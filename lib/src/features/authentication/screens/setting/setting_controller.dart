import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  RxBool notificationsEnabled = false.obs;
  RxBool darkModeEnabled = false.obs;
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled.value = prefs.getBool('notifications') ?? true;
    darkModeEnabled.value = prefs.getBool('darkMode') ?? false;
    _themeMode.value = darkModeEnabled.value ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> updateNotificationSetting(bool value) async {
    try {
      if (value) {
        final status = await Permission.notification.request();
        if (status.isGranted) {
          notificationsEnabled.value = true;
        } else {
          notificationsEnabled.value = false;
          _showPermissionDeniedMessage();
          return;
        }
      } else {
        notificationsEnabled.value = false;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications', notificationsEnabled.value);
    } catch (e) {
      print("Notification permission error: $e");
      notificationsEnabled.value = false;
      _showPermissionDeniedMessage();
    }
  }

  Future<void> toggleDarkMode(bool value) async {
    darkModeEnabled.value = value;
    _themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    Get.changeThemeMode(_themeMode.value);
  }

  Future<void> _requestNotificationPermissions() async {
    final status = await Permission.notification.request();
    if (status.isDenied) {
      notificationsEnabled.value = false;
      Get.snackbar(
        'Permission Required',
        'Please enable notifications in device settings',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Update shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications', false);
    }
  }

  void _showPermissionDeniedMessage() {
    Get.snackbar(
      'Permission Required',
      'Please enable notifications in device settings',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: () => openAppSettings(),
        child: const Text('OPEN SETTINGS'),
      ),
    );
  }
}
