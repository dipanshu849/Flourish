import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  final String currencySign, price;
  final int maxline;
  final bool isLarge;
  final bool lineThough;

  const ProductPriceText(
      {Key? key,
      this.currencySign = "\u{20B9}",
      required this.price,
      this.isLarge = false,
      this.maxline = 1,
      this.lineThough = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Text(currencySign + price,
        maxLines: maxline,
        overflow: TextOverflow.ellipsis,
        style: isLarge
            ? Theme.of(context).textTheme.headlineMedium!.apply(
                  decoration: lineThough ? TextDecoration.lineThrough : null,
                  color: isDark ? light : dark,
                )
            : Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: lineThough ? TextDecoration.lineThrough : null,
                  color: isDark ? light : dark,
                ));
  }
}
