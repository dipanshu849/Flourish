import 'package:flourish/src/features/authentication/screens/login/login_form.dart';
import 'package:flourish/src/features/authentication/screens/login/login_header.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeaderWidget(size: size),
              const SizedBox(
                height: 20,
              ),
              const LoginForm(),
              // const LoginFooterWidget()
            ],
          ),
        ),
      ),
    ));
  }
}
