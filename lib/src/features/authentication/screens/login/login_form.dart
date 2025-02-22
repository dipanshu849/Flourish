import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/features/authentication/screens/sign_up/sign_up.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    final obscurePassword = true.obs;
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Email",
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(() => TextFormField(
                  controller: controller.password,
                  obscureText: obscurePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: "Password",
                    hintText: "Enter your password",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                )),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              controller.signInUser().then((success) {
                                if (success) {
                                  Get.offAll(() => const NavigationMenu());
                                }
                              });
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text("Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: isDark ? slate600 : light)),
                  ),
                )),
            const SizedBox(height: spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(const SignUpScreen());
                },
                child: Text("Create Account",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: isDark ? light : slate800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
