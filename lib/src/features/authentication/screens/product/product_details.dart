import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/common_style/rounded_image.dart';
import 'package:flourish/src/common_widget/icon/circular_icon.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/features/authentication/screens/product/product_detail_image_slider.dart';
import 'package:flourish/src/features/authentication/screens/product/product_meta_data.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/features/authentication/screens/product/rating_review.dart';
import 'package:flourish/src/features/authentication/screens/review/review.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});

  final ProductModel product;
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    // Assuming `Product` is your product model

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PRODUCT IMAGE SLIDER

            ProductDetailImageSlider(
                images: product.imageUrl), // Pass product images

            // PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.only(
                  right: defaultSize, left: defaultSize, bottom: defaultSize),
              child: Column(
                children: [
                  const SizedBox(height: spaceBtwItems / 2),

                  // PRODUCT NAME - PRICE
                  ProductMetaData(product: product), // Pass product data

                  const Divider(),
                  const SizedBox(height: spaceBtwItems / 2),

                  // SELLER INFO
                  Row(
                    children: [
                      const CircularIcon(
                        icon: LineAwesomeIcons.user,
                        iconColor: rose,
                      ),
                      const SizedBox(width: spaceBtwItems / 4),
                      FutureBuilder(
                        future:
                            authController.fetchUserDetail(product.sellerId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!['email']
                                  .toString()
                                  .substring(0, 6),
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          } else {
                            return const Text(
                                'Hacker'); // or some other default value
                          }
                        },
                      ),
                      const SizedBox(width: defaultSize),
                      // RATING
                      // RatingReview(product: product), // Pass product rating
                    ],
                  ),

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
                        // onPressed: () => Get.to(() => ReviewScreen(productId: product.id)),
                        onPressed: () {},
                        icon: Icon(
                          LineAwesomeIcons.angle_right_solid,
                          color: isDark ? light : dark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
