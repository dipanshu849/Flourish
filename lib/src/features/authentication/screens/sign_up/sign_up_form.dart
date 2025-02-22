import 'package:flourish/src/features/authentication/screens/sign_up/verifiy_email.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  // final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final obscurePassword = true.obs;
    final isDark = HelperFunction.isDarkMode();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        // key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              // controller: controller.fullName,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Full Name",
                hintText: "Enter your full name",
                prefixIcon: Icon(Icons.person_outline_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              // controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              // controller: controller.password,
              obscureText: obscurePassword.value,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.fingerprint),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    obscurePassword.value = !obscurePassword.value;
                  },
                  icon: Icon(obscurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //         onPressed: () {},
            //         // onPressed: controller.isLoading.value
            //         // ? null
            //         // : () {
            //         //     String email = controller.email.text.trim();
            //         //     print("reached Here");
            //         //     bool isValidIITMandiEmail = RegExp(
            //         //             r'^[a-zA-Z0-9._%+-]+@(students\.)?iitmandi\.ac\.in$')
            //         //         .hasMatch(email);
            //         //     if (!isValidIITMandiEmail) {
            //         //       Get.snackbar(
            //         //         "Invalid Email",
            //         //         "Please enter a valid IIT Mandi email.",
            //         //         snackPosition: SnackPosition.BOTTOM,
            //         //         backgroundColor: Colors.red,
            //         //         colorText: Colors.white,
            //         //       );
            //         //     } else if (controller.role.value.isEmpty) {
            //         //       // Show error if no role is selected
            //         //       Get.snackbar(
            //         //         "Role Required",
            //         //         "Please select your role (Resident or Worker).",
            //         //         snackPosition: SnackPosition.BOTTOM,
            //         //         backgroundColor: Colors.red,
            //         //         colorText: Colors.white,
            //         //       );
            //         //     } else {
            //         //       print("ALSO here");
            //         //       controller.createUser();
            //         //     }
            //         //   },
            //         child:
            //             // controller.isLoading.value
            //             //     ? const ButtonLoadingWidget()
            //             //     :
            //             const Text("Create Account"))),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const MailVerification());
                },
                // controller.isLoading.value
                //     ? () {}
                //     : () => controller.login(),
                child:
                    // controller.isLoading.value
                    //     ? const ButtonLoadingWidget()
                    //     :
                    Text("Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: isDark ? slate600 : light)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
