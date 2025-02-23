import 'package:flourish/src/features/authentication/screens/review/review_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/device/device_utility.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ReviewScreen extends StatelessWidget {
  final String sellerId;
  final ReviewController reviewController = Get.put(ReviewController());

  ReviewScreen({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review & Rating',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: isDark ? light : slate800, fontSizeFactor: 0.8),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: isDark ? light : slate800),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: reviewController.getSellerReviews(sellerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("No reviews yet"));
          }

          final reviews = snapshot.data!['reviews'];
          final avgRating = snapshot.data!['average_rating'];
          final totalRatings = snapshot.data!['total_ratings'];
          final ratingDistribution = snapshot.data!['rating_distribution'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ratings & reviews are verified and are from people who have purchased the product from the seller",
                  ),
                  const SizedBox(height: spaceBtwItems),

                  // Overall Rating Section
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            totalRatings > 0
                                ? avgRating.toStringAsFixed(1)
                                : "0",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: List.generate(5, (index) {
                            int star = 5 - index;
                            return RatingProgressIndicator(
                              text: star.toString(),
                              value: ratingDistribution[star] /
                                  (totalRatings == 0 ? 1 : totalRatings),
                            );
                          }),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: spaceBtwItems),

                  // User Reviews List
                  if (reviews.isNotEmpty)
                    ListView.builder(
                      itemCount: reviews.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review['buyer_name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: isDark ? light : slate800),
                            ),
                            const SizedBox(height: spaceBtwItems / 2),
                            Text(
                              review['created_at'].split("T")[0], // Format date
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: spaceBtwItems / 2),
                            ReadMoreText(
                              review['review_text'],
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: "Show more",
                              trimExpandedText: "Show less",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: slate400),
                              moreStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: indigo),
                              lessStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: indigo),
                            ),
                            const SizedBox(height: spaceBtwItems),
                          ],
                        );
                      },
                    )
                  else
                    const Center(child: Text("No reviews yet")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  final String text;
  final double value;

  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: DeviceUtility.getScreenWidth(context) * 0.5,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: slate600,
              valueColor: const AlwaysStoppedAnimation(rose),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        )
      ],
    );
  }
}
