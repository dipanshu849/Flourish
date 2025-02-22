import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/device/device_utility.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

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
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? light : slate800, // Change the color here
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ratings & reviews are verified and are from people who have purchased the product from the seller",
                ),
                const SizedBox(
                  height: spaceBtwItems,
                ),

                // overall rating

                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "4.8",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          RatingProgressIndicator(
                            text: '5',
                            value: 0.3,
                          ),
                          RatingProgressIndicator(
                            text: '4',
                            value: 0.3,
                          ),
                          RatingProgressIndicator(
                            text: '3',
                            value: 0.3,
                          ),
                          RatingProgressIndicator(
                            text: '2',
                            value: 0.3,
                          ),
                          RatingProgressIndicator(
                            text: '1',
                            value: 0.3,
                          )
                        ],
                      ),
                    )
                  ],
                ),

                // USER REVIEW LIST
                const SizedBox(
                  height: spaceBtwItems,
                ),

                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Doe",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: isDark ? light : slate800),
                        ),
                        const SizedBox(
                          height: spaceBtwItems / 2,
                        ),
                        Text(
                          '22 Feb 2025',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: spaceBtwItems / 2,
                        ),
                        ReadMoreText(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet erat non nisi malesuada condimentum. Fusce id nulla vitae lectus malesuada lobortis. Mauris id nulla vitae lectus malesuada lobortis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In hac habitasse platea dictumst. Sed sed lectus vitae nulla malesuada lobortis. In hac habitasse platea dictumst. Sed sed lectus vitae nulla malesuada lobortis. In hac habitasse platea dictumst. Sed sed lectus vitae nulla malesuada lobortis. In hac habitasse platea dictumst. Sed sed lectus vitae nulla malesuada lobortis. In hac habitasse platea dictumst.",
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
                        const SizedBox(
                          height: spaceBtwItems,
                        ),
                        // const Divider(
                        //   height: 1,
                        //   thickness: 1,
                        // ),
                        const SizedBox(
                          height: spaceBtwItems,
                        ),
                      ],
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

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
