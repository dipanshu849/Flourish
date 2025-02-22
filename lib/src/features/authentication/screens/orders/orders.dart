import 'package:flourish/src/features/authentication/screens/orders/order_list_items.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
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
      body: const Padding(
        padding: EdgeInsets.all(defaultSize),
        // ORDERS
        child: OrderListItems(),
      ),
    );
  }
}
