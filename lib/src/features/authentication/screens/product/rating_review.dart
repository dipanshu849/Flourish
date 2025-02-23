import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/features/authentication/screens/review/review_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingReview extends StatelessWidget {
  final ProductModel product;
  final ReviewController reviewController = Get.put(ReviewController());

  RatingReview({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);

    return FutureBuilder(
      future: reviewController.getSellerReviewStats(product.sellerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text("No ratings yet");
        }

        final double avgRating =
            (snapshot.data as Map<String, dynamic>?)?['average_rating'] ?? 0.0;
        final int totalRatings =
            (snapshot.data as Map<String, dynamic>?)?['total_ratings'] ?? 0;

        return Row(
          children: [
            Icon(Icons.star_rate, color: isDark ? slate400 : dark),
            const SizedBox(width: spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: totalRatings > 0
                        ? avgRating.toStringAsFixed(1) // Show rating if exists
                        : "No ratings", // Show message if no ratings
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (totalRatings > 0) // Only show count if ratings exist
                    TextSpan(
                      text: ' ($totalRatings)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
