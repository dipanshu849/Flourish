import 'package:flourish/src/common_style/rounded_container.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(
        height: spaceBtwItems,
      ),
      itemBuilder: (_, index) => RoundedContainer(
        borderColor: slate600,
        padding: const EdgeInsets.all(md),
        showBorder: true,
        backgroundColor: isDark ? dark : light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ROW -- 1
            Row(
              children: [
                // 1 -icon
                Icon(LineAwesomeIcons.ship_solid,
                    color: isDark ? slate400 : dark),
                const SizedBox(
                  width: spaceBtwItems / 2,
                ),

                // 2 - STATUS & DATE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Delivered",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: isDark ? slate400 : dark),
                      ),
                      const SizedBox(
                        height: spaceBtwItems / 2,
                      ),
                      Text(
                        "27th May, 2023",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: isDark ? slate400 : dark),
                      ),
                    ],
                  ),
                ),

                // 3 - order number
                // const Spacer(),

                Text(
                  "#1234",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: isDark ? light : dark),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
