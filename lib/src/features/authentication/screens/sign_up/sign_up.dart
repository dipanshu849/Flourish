import 'package:flourish/src/features/authentication/screens/sign_up/sign_up_form.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/constants/text_strings.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  singUpTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .apply(color: isDark ? light : slate600),
                ),
                Text(singUpSubTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: isDark ? light : slate400)),
                const SizedBox(
                  height: 20,
                ),
                SignUpForm(),
                // const SignUpFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
