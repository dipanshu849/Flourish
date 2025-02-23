import 'dart:async';

import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/features/authentication/screens/onboarding.dart';
import 'package:flourish/src/features/authentication/screens/sign_up/mail_verified.dart';
import 'package:flourish/src/features/authentication/screens/sign_up/verifiy_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final supabase = Supabase.instance.client;

  var userEmail = "".obs;
  var userName = "".obs;

  // Controllers for text fields
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final isLoading = false.obs; // Loading state

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void startAuthChecking() {
    final user = supabase.auth.currentUser;
    if (user != null && user.emailConfirmedAt != null) {
      Get.to(() => const NavigationMenu());
    }
  }

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      userEmail.value = "No Email";
      userName.value = "No Name";
      print("No user is logged in!");
      return;
    }

    print("User ID: ${user.id}"); // Debugging

    userEmail.value = user.email ?? "No Email";

    try {
      final response = await supabase
          .from('users')
          .select('full_name')
          .eq('id', user.id)
          .maybeSingle();

      if (response != null && response['full_name'] != null) {
        userName.value = response['full_name'];
      } else {
        userName.value = "No Name Found";
      }
    } catch (e) {
      userName.value = "Error Fetching Name";
      Get.snackbar("Error", "Failed to load user data: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Future<void> fetchUserData() async {
  //   final user = supabase.auth.currentUser;
  //   if (user == null) {
  //     userEmail.value = "No Email";
  //     userName.value = "No Name";
  //     return;
  //   }

  //   userEmail.value = user.email ?? "No Email";

  //   try {
  //     final response = await supabase
  //         .from('users')
  //         .select('full_name')
  //         .eq('id', user.id)
  //         .maybeSingle(); // Use maybeSingle() to prevent crashes

  //     if (response != null && response['full_name'] != null) {
  //       userName.value = response['full_name'];
  //     } else {
  //       userName.value = "No Name Found";
  //     }
  //   } catch (e) {
  //     userName.value = "Error Fetching Name";
  //     Get.snackbar("Error", "Failed to load user data: $e",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  /// Sign Up User
  // Future<bool> signUpUser() async {
  //   try {
  //     isLoading.value = true; // Show loading indicator

  //     final response = await supabase.auth.signUp(
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //     );

  //     if (response.user != null) {
  //       // Add user details to the 'users' table
  //       await supabase.from('users').insert({
  //         'id': response.user!.id,
  //         'email': email.text.trim(),
  //         'full_name': fullName.text.trim(),
  //       });

  //       Get.to(() => const NavigationMenu());
  //       Get.snackbar("Sign Up Successful", "Welcome to Flourish!",
  //           backgroundColor: Colors.green, colorText: Colors.white);
  //       return true;
  //     } else {
  //       Get.snackbar("Sign Up Failed", "User could not be created.",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //       return false;
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<bool> signUpUser() async {
    try {
      isLoading.value = true; // Show loading indicator

      final AuthResponse response = await supabase.auth.signUp(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final user = response.user;
      if (user != null) {
        await supabase.from('users').insert({
          'id': user.id,
          'email': email.text.trim(),
          'full_name': fullName.text.trim(),
        });

        // Fetch user data after signing up
        await fetchUserData();

        Get.to(() => const NavigationMenu());
        Get.snackbar("Sign Up Successful", "Welcome to Flourish!",
            backgroundColor: Colors.green, colorText: Colors.white);
        return true;
      } else {
        Get.snackbar("Sign Up Failed", "User could not be created.",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> signInUser() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await supabase.auth.signInWithPassword(
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //     );

  //     if (response.user != null) {
  //       await fetchUserData(); // Ensure user data is loaded after login
  //       Get.snackbar("Login Successful", "Welcome back!",
  //           backgroundColor: Colors.green, colorText: Colors.white);
  //       return true;
  //     } else {
  //       Get.snackbar("Login Failed", "Invalid credentials.",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //       return false;
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<bool> signInUser() async {
    try {
      isLoading.value = true;

      final response = await supabase.auth.signInWithPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response.user != null) {
        print("User ID after login: ${response.user!.id}"); // Debugging

        await fetchUserData();

        Get.snackbar("Login Successful", "Welcome back!",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => const NavigationMenu()); // Navigate to the main screen
        return true;
      } else {
        Get.snackbar("Login Failed", "Invalid credentials.",
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser(RxBool isLoggingOut) async {
    try {
      isLoggingOut.value = true;
      await Supabase.instance.client.auth.signOut();
      Get.offAll(() => const OnBoardingScreen()); // Redirect to login
      Get.snackbar("Logout", "You have been logged out",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoggingOut.value = false;
    }
  }

  /// Fetch current user id
  String? get currentUserId => supabase.auth.currentUser?.id;

  /// Fetch user detail with help of userId
  Future<Map<String, dynamic>?> fetchUserDetail(String? userId) async {
    if (userId == null) return null;

    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;

    return response;
  }
}
