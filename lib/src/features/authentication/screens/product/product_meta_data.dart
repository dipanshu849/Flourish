import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/common_style/rounded_container.dart';
import 'package:flourish/src/common_widget/text/product_price_text.dart';
import 'package:flourish/src/common_widget/text/product_title_text.dart';
import 'package:flourish/src/features/authentication/screens/chat/chat.dart';
import 'package:flourish/src/features/authentication/screens/chat/chat_query/chat_controller.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class ProductMetaData extends StatelessWidget {
  final ProductModel product; // Accept the product object

  ProductMetaData({super.key, required this.product});

  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);

    // Calculate the discounted price
    final double originalPrice =
        double.parse(product.price.toDouble().toStringAsFixed(2));
    final double discount =
        double.parse(product.discount!.toDouble().toStringAsFixed(2));
    final double discountedPrice =
        originalPrice - (originalPrice * discount / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PRICE & DISCOUNT
        Row(
          children: [
            // DISCOUNT
            if (discount > 0) // Show discount only if it exists
              RoundedContainer(
                radius: sm,
                backgroundColor: rose.withOpacity(0.8),
                padding:
                    const EdgeInsets.symmetric(horizontal: sm, vertical: xs),
                child: Text(
                  "${discount.toStringAsFixed(0)}%",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: isDark ? light : dark),
                ),
              ),
            if (discount > 0) const SizedBox(width: spaceBtwItems),

            // ORIGINAL PRICE (WITH LINE-THROUGH)
            if (discount > 0)
              ProductPriceText(
                price: originalPrice.toStringAsFixed(2),
                isLarge: false,
                lineThough: true,
              ),
            if (discount > 0) const SizedBox(width: spaceBtwItems),

            // DISCOUNTED PRICE
            ProductPriceText(
              price: discountedPrice.toStringAsFixed(2),
              isLarge: true,
            ),
          ],
        ),

        const SizedBox(height: spaceBtwItems / 1.4),

        // TITLE
        ProductTitleWidget(
          title: product.title,
          maxLines: 2,
          smallSize: false,
        ),

        const SizedBox(height: spaceBtwItems / 1.4),

        // CONDITION
        Text(
          "Condition: ${product.condition}",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: slate600, fontWeightDelta: 3),
        ),
        const SizedBox(height: spaceBtwItems / 2),

        // DESCRIPTION
        Text(
          "Description",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .apply(color: slate600, fontWeightDelta: 3),
        ),
        const SizedBox(height: spaceBtwItems / 2),
        ReadMoreText(
          product.description,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show more",
          trimExpandedText: "Show less",
          style: Theme.of(context).textTheme.bodySmall!.apply(color: slate400),
          moreStyle:
              Theme.of(context).textTheme.bodySmall!.apply(color: indigo),
          lessStyle:
              Theme.of(context).textTheme.bodySmall!.apply(color: indigo),
        ),

        const SizedBox(height: spaceBtwItems),

        // CHAT BUTTON
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // _showChatDialog(context, product.sellerId, authController.currentUserId!, product.id);
              if (authController.currentUserId != null) {
                _showChatDialog(context, product.sellerId,
                    authController.currentUserId!, product.id);
              } else {
                Get.snackbar("Error", "User ID is null");
                // Handle the case where authController.currentUserId is null
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(sm)),
              ),
              backgroundColor: isDark ? dark : light,
              padding: const EdgeInsets.symmetric(
                horizontal: spaceBtwItems,
                vertical: spaceBtwItems / 2.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LineAwesomeIcons.comment,
                  size: 20,
                  color: isDark ? light : slate800,
                ),
                const SizedBox(width: spaceBtwItems / 2),
                Center(
                  child: Text(
                    "Chat with Seller",
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                          color: isDark ? light : dark,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Show chat dialog
  void _showChatDialog(
      BuildContext context, String sellerId, String buyerId, String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Start Chat"),
        content: Text("Do you want to start a chat with seller $sellerId?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              String? chatId = await chatController.initializeChat(
                  sellerId, buyerId, productId);

              if (chatId != null) {
                Get.to(() => const ChatScreen());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Failed to start chat. Please try again.")),
                );
              }
            },
            child: const Text("Start Chat"),
          ),
        ],
      ),
    );
  }
}
