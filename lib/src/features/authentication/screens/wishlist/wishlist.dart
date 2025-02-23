import 'package:flourish/src/common_widget/layout/grid_layout.dart';
import 'package:flourish/src/common_widget/product/product_card_vertical.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/circular_container.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/features/authentication/screens/wishlist/wishlist_query/wishlist_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatefulWidget {
  final WishlistController _controller = Get.put(WishlistController());

  WishlistScreen({super.key}) {
    _controller.fetchWishlist();
  }

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final size = HelperFunction.getScreenSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedEdgeWidget(
              child: Container(
                color: slate400,
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: size.height * 0.135,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -150,
                        right: -250,
                        child: CircularContainer(
                            backgroundColor: light.withOpacity(0.1)),
                      ),
                      Positioned(
                        top: 100,
                        right: -300,
                        child: CircularContainer(
                            backgroundColor: light.withOpacity(0.1)),
                      ),
                      // app bar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          title: Text(
                            "Wishlist",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(color: slate800, fontSizeFactor: 0.8),
                            // style: TextStyle(
                            //     fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                    ],
                    // user profile card
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultSize),
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.8, // Set a defined height
                child: Obx(() {
                  if (widget._controller.wishlistItems.isEmpty) {
                    return const Center(
                        child: Text("No items in your wishlist"));
                  }

                  return GridLayout(
                    itemCount: widget._controller.wishlistItems.length,
                    itemBuilder: (context, index) {
                      final productData =
                          widget._controller.wishlistItems[index]['products'];

                      // Convert map to ProductModel
                      final product = ProductModel.fromJson(productData);

                      return ProductCardVertical(product: product);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
