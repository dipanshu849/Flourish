import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/text_strings.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(loginImage),
          height: size.height * 0.2,
        ),
        Text(
          loginTitle,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: isDark ? light : slate600),
        ),
        Text(
          loginSubtitle,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .apply(color: isDark ? light : slate400),
        ),
      ],
    );
  }
}
