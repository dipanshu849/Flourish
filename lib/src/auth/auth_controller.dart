import 'package:flourish/src/features/authentication/screens/onboarding.dart';
import 'package:flourish/src/features/authentication/screens/sign_up/sign_up.dart';
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

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userEmail.value = user.email ?? "No Email";

      // Fetch user details from database
      final response = await supabase
          .from('users')
          .select('full_name')
          .eq('id', user.id)
          .single();

      if (response != null) {
        userName.value = response['full_name'];
      }
    }
  }

  /// Sign Up User
  Future<void> signUpUser() async {
    try {
      isLoading.value = true; // Show loading indicator

      final response = await supabase.auth.signUp(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response.user != null) {
        // Add user details to the 'users' table
        await supabase.from('users').insert({
          'id': response.user!.id,
          'email': email.text.trim(),
          'full_name': fullName.text.trim(),
        });

        Get.to(() => const MailVerification());
      } else {
        Get.snackbar("Sign Up Failed", "User could not be created.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign In User
  Future<bool> signInUser() async {
    try {
      isLoading.value = true;

      final response = await supabase.auth.signInWithPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response.user != null) {
        Get.snackbar("Login Successful", "Welcome back!",
            backgroundColor: Colors.green, colorText: Colors.white);
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

  /// Sign Out User
  Future<void> signOutUser() async {
    try {
      await supabase.auth.signOut();
      Get.snackbar("Logged Out", "You have been logged out successfully.",
          backgroundColor: Colors.blue, colorText: Colors.white);
      Get.offAll(() => SignUpScreen()); // Redirect to SignUp/Login page
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void logoutUser() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAll(() => const OnBoardingScreen()); // Redirect to login
    Get.snackbar("Logout", "You have been logged out",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}
