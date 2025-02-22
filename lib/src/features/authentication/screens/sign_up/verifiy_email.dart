import 'package:flourish/src/features/authentication/screens/sign_up/mail_verified.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(MailVerificationController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              // actions: [
              //   IconButton(
              //     onPressed: () => Get.back(),
              //     icon: const Icon(LineAwesomeIcons.),
              //   )
              // ],
              ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5 * defaultSize,
                  left: defaultSize,
                  right: defaultSize,
                  bottom: defaultSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LineAwesomeIcons.envelope_open_solid, size: 100),
                  const SizedBox(height: defaultSize),
                  Text(emailVerificationTitle,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: defaultSize),
                  const Text(
                    emailVerificationSubTitle1,
                    // style: Theme.of(context).textTheme.bodyLarge,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    emailVerificationSubTitle2,
                    // style: Theme.of(context).textTheme.bodyMedium,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: OutlinedButton(
                        onPressed: () {
                          Get.to(() => const MailVerified());
                        },
                        // controller.mannuallyCheckMailVerificationStatus(),
                        child: const Text(
                          "Continue",
                        )),
                  ),
                  const SizedBox(height: defaultSize),
                  TextButton(
                      // onPressed: () => controller.sendVerificationMail(),
                      onPressed: () {},
                      child: const Text('Resend email link')),
                ],
              ),
            ),
          )),
    );
  }
}
