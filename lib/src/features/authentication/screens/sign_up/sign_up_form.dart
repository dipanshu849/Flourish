import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final obscurePassword = true.obs;
    final isDark = HelperFunction.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.fullName,
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
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => TextField(
                  controller: controller.password,
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
                )),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.signUpUser(),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text("Create Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: isDark ? slate600 : light)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
