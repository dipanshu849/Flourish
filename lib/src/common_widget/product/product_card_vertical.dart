import 'package:flourish/src/common_style/rounded_container.dart';
import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_style/shadow.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/common_widget/text/product_price_text.dart';
import 'package:flourish/src/common_widget/text/product_title_text.dart';
import 'package:flourish/src/features/authentication/screens/product/product_details.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../utils/constants/colors.dart';

class ProductCardVertical extends StatelessWidget {
  final ProductModel product;
  const ProductCardVertical({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails(product: product)),
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
              width: double.infinity, // Ensure full horizontal width
              height: 180,
              padding: const EdgeInsets.all(sm),
              backgroundColor: isDark ? slate400 : light,
              child: Stack(
                children: [
                  // Thumbnail Image (Ensure it fills container)
                  Positioned.fill(
                      // This makes the image fill the container
                      child: RoundedImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: (product.imageUrl != null &&
                            product.imageUrl.isNotEmpty)
                        ? product.imageUrl[0]
                        : placeholderImage,
                    applyImageRadius: true,
                    isNetworkImage: true,
                    fit: BoxFit.cover,
                  )),

                  // SALE TAG
                  Positioned(
                    top: 4,
                    left: 2,
                    child: RoundedContainer(
                      radius: sm,
                      backgroundColor: rose.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: sm,
                        vertical: xs,
                      ),
                      child: Text(
                        "${product.discount}%",
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
                  ),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ProductTitleWidget(
                      title: product.title,
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
                      ProductPriceText(
                        price: product.price.toString(),
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
