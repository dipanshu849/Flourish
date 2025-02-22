import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/features/authentication/screens/product/product_detail_image_slider.dart';
import 'package:flourish/src/features/authentication/screens/product/product_meta_data.dart';
import 'package:flourish/src/features/authentication/screens/product/rating_review.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PRODUCT IMAGE SLIDER
            const ProductDetailImageSlider(),

            // PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.only(
                  right: defaultSize, left: defaultSize, bottom: defaultSize),
              child: Column(
                children: [
                  const SizedBox(
                    height: spaceBtwItems / 2,
                  ),

                  // PRODUCT NAME - PRICE
                  const ProductMetaData(),

                  const Divider(),
                  const SizedBox(
                    height: spaceBtwItems / 2,
                  ),

                  // SELLER INFO
                  Row(children: [
                    const CircularIcon(
                      icon: LineAwesomeIcons.user,
                      iconColor: rose,
                    ),
                    const SizedBox(
                      width: spaceBtwItems / 4,
                    ),
                    Text(
                      "B23126",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(
                      width: defaultSize,
                    ),
                    // RATING
                    const RatingReview(),
                  ]),

                  // REVIEWS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reviews",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: isDark ? light : dark),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            LineAwesomeIcons.angle_right_solid,
                            color: isDark ? light : dark,
                          )),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
