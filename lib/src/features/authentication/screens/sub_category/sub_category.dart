import 'package:flourish/src/common_widget/product/product_card_horizontal.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/device/device_utility.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category',
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
              // sub-categories
              children: [
                SizedBox(
                  width: DeviceUtility.getScreenWidth(context),
                  height: DeviceUtility.getScreenHeight(context) * 0.8,
                  child: ListView.separated(
                    itemBuilder: (_, index) => ProductCardHorizontal(),
                    separatorBuilder: (_, index) => const SizedBox(
                      height: spaceBtwItems,
                    ),
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                  ),
                )
                // ProductCardHorizontal(),
              ],
            )),
      ),
    );
  }
}
