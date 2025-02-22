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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants/colors.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(10),
          color: isDark ? dark : slate400.withOpacity(0.2),
        ),
        child: Column(
          children: [
            // thumbnail, wishlist btn, discount
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(sm),
              backgroundColor: isDark ? slate400 : light,
              child: Stack(
                children: [
                  // thumbnail
                  const RoundedImage(
                    imageUrl: loginImage,
                    applyImageRadius: true,
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

                  // Wishlist Button
                  const Positioned(
                    top: -6,
                    right: 0,
                    child: CircularIcon(
                      icon: Icons.favorite_border_outlined,
                      iconColor: rose,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: spaceBtwItems / 2),
            // -- details
            Padding(
              padding: const EdgeInsets.only(left: sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ProductTitleWidget(
                      title: "Product Title",
                      smallSize: true,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 1,
                  // ),
                  // Text("B23126",
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 1,
                  //     // style: Theme.of(context) ,

                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodySmall!
                  //         .apply(color: indigo.withOpacity(0.9))),

                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const ProductPriceText(
                        price: '100',
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: light,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: SizedBox(
                            width: 60,
                            height: 30,
                            child: Center(
                                child: Icon(
                              LineAwesomeIcons.cart_plus_solid,
                              color: isDark ? dark : slate800,
                            ))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
