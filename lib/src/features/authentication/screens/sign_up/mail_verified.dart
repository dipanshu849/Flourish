import 'package:flourish/navigation_menu.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerified extends StatelessWidget {
  const MailVerified({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 5 * defaultSize,
                left: defaultSize,
                right: defaultSize,
                bottom: defaultSize),
            child: Center(
              // Added Center widget here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.verified, size: 100),
                  const SizedBox(height: defaultSize),
                  Text(
                    emailVerifiedTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center, // Added for better centering
                  ),
                  const Text(
                    emailVerifiedSubTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: defaultSize),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.offAll(() => const NavigationMenu());
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
