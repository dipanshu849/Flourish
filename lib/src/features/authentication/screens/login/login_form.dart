import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/features/authentication/screens/sign_up/sign_up.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = HelperFunction.getScreenSize(context);
    final isdark = HelperFunction.isDarkMode(context);
    final obscurePassword = true.obs;
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // autofocus: true,
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
            const SizedBox(
              height: 20,
            ),
            Obx(() => TextFormField(
                  obscureText: obscurePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Toggle password visibility
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
            Row(
              children: [
                Checkbox(
                  value: true, // This should be linked to a state variable
                  onChanged: (bool? newValue) {
                    // Handle checkbox state change
                  },
                ),
                const Text('Remember Me'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const NavigationMenu());
                },
                // controller.isLoading.value
                //     ? () {}
                //     : () => controller.login(),
                child:
                    // controller.isLoading.value
                    //     ? const ButtonLoadingWidget()
                    //     :
                    Text("Login",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: isdark ? slate600 : light)),
              ),
            ),
            const SizedBox(
              height: spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(const SignUpScreen());
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
                            .apply(color: isdark ? light : slate800)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
