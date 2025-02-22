import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

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
    );
  }
}
