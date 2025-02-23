import 'package:flourish/src/common_widget/layout/grid_layout.dart';
import 'package:flourish/src/common_widget/product/product_card_vertical.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: slate800, fontSizeFactor: 0.8),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              // GridLayout(
              //     itemCount: 4,
              //     itemBuilder: (_, index) =>  ProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
