import 'package:flourish/src/common_style/rounded_container.dart';
import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_style/shadow.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/common_widget/text/product_price_text.dart';
import 'package:flourish/src/common_widget/text/product_title_text.dart';
import 'package:flourish/src/features/authentication/screens/product/product_details.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Container(
      width: 600,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [ShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(10),
        color: isDark ? dark : slate400.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // thumbnail
          RoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(sm),
            backgroundColor: isDark ? slate400 : light,
            child: Stack(
              children: [
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: RoundedImage(
                    imageUrl: loginImage,
                    applyImageRadius: true,
                  ),
                ),

                // SALE TAG
                Positioned(
                  top: 6,
                  child: RoundedContainer(
                    radius: sm,
                    backgroundColor: rose.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: sm,
                      vertical: xs,
                    ),
                    child: Text(
                      "25%",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: light),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DETAILS
          const SizedBox(
            width: 172,
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitleWidget(
                        title: "Product Name",
                        maxLines: 2,
                        // smallSize: true,
                      ),
                      SizedBox(
                        height: spaceBtwItems / 2,
                      ),
                      ProductPriceText(
                        price: "100",
                        isLarge: true,
                      ),
                      SizedBox(
                        height: spaceBtwItems,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // check out
          Column(
            children: [
              // Wishlist Button
              const Positioned(
                top: 0,
                right: 0,
                child: CircularIcon(
                  icon: Icons.favorite_border_outlined,
                  iconColor: rose,
                ),
              ),
              const SizedBox(
                height: spaceBtwItems / 2,
              ),

              Container(
                decoration: const BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                        child: Icon(
                      LineAwesomeIcons.cart_plus_solid,
                      color: isDark ? dark : slate800,
                    ))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
