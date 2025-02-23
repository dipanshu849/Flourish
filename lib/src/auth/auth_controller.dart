import 'package:flourish/src/features/authentication/screens/onboarding.dart';
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

//   Future<void> fetchUserData() async {
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
//       // Debugging: Log the issue
//       print("User data not found for ID: ${user.id}");
//     }
//   } catch (e) {
//     userName.value = "Error Fetching Name";
//     Get.snackbar("Error", "Failed to load user data: $e",
//         backgroundColor: Colors.red, colorText: Colors.white);
//     // Debugging: Log the error
//     print("Error fetching user data: $e");
//   }
// }

  Future<void> fetchUserData() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      print("No user is currently logged in.");
      userEmail.value = "No Email";
      userName.value = "No Name";
      return;
    }

    print("Fetching data for user ID: ${user.id}");
    userEmail.value = user.email ?? "No Email";

    try {
      final response = await supabase
          .from('users')
          .select('full_name')
          .eq('id', user.id)
          .maybeSingle();

      print("Database response: $response");

      if (response != null && response['full_name'] != null) {
        userName.value = response['full_name'];
        print("User name fetched: ${userName.value}");
      } else {
        userName.value = "No Name Found";
        print("No name found for user ID: ${user.id}");
      }
    } catch (e) {
      userName.value = "Error Fetching Name";
      print("Error fetching user data: $e");
      Get.snackbar("Error", "Failed to load user data: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

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

  //       Get.to(() => const MailVerification());
  //       Get.snackbar("Sign Up Successful", "Verfiy your email.",
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

  // Future<bool> signUpUser() async {
  //   try {
  //     isLoading.value = true; // Show loading indicator

  //     // Step 1: Sign up the user with Supabase Auth
  //     final response = await supabase.auth.signUp(
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //     );

  //     if (response.user != null) {
  //       // Step 2: Insert user details into the 'users' table
  //       await supabase.from('users').insert({
  //         'id': response.user!.id,
  //         'email': email.text.trim(),
  //         'full_name': fullName.text.trim(),
  //       });

  //       // Step 3: Fetch the user data immediately after sign-up
  //       await fetchUserData();

  //       // Step 4: Navigate to the verification screen
  //       Get.to(() => const MailVerification());
  //       Get.snackbar("Sign Up Successful", "Verify your email.",
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
      isLoading.value = true;

      // Step 1: Sign up the user
      final response = await supabase.auth.signUp(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response.user != null) {
        // Step 2: Insert user details into the 'users' table
        final insertResponse = await supabase.from('users').insert({
          'id': response.user!.id,
          'email': email.text.trim(),
          'full_name': fullName.text.trim(),
        }).select();

        // Debugging: Log the insert response
        print("Insert Response: $insertResponse");

        // Step 3: Verify the data was inserted
        if (insertResponse != null) {
          await fetchUserData();
          Get.to(() => const MailVerification());
          Get.snackbar("Sign Up Successful", "Verify your email.",
              backgroundColor: Colors.green, colorText: Colors.white);
          return true;
        } else {
          Get.snackbar("Sign Up Failed", "User data could not be saved.",
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
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

  Future<bool> signInUser() async {
    try {
      isLoading.value = true;
      final response = await supabase.auth.signInWithPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (response.user != null) {
        await fetchUserData(); // Ensure user data is loaded after login
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
