import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class RatingReview extends StatelessWidget {
  const RatingReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Row(
      children: [
        Icon(Icons.star_rate, color: isDark ? slate400 : dark),
        const SizedBox(
          width: spaceBtwItems / 2,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: '4.5',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const TextSpan(text: '(21)')
        ]))
      ],
    );
  }
}
