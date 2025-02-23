// import 'package:flourish/src/common_widget/product/product_card_horizontal.dart';
// import 'package:flourish/src/features/authentication/screens/product/product_quries/product_controller.dart';
// import 'package:flourish/src/utils/constants/colors.dart';
// import 'package:flourish/src/utils/constants/sizes.dart';
// import 'package:flourish/src/utils/device/device_utility.dart';
// import 'package:flourish/src/utils/helpers/helper_function.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SubCategoryScreen extends StatelessWidget {
//   final String categoryName;
//   const SubCategoryScreen({super.key, required this.categoryName});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = HelperFunction.isDarkMode(context);
//     final ProductController productController = Get.put(ProductController());

//     final filteredProducts = productController.products
//         .where((product) => product.tags.contains(categoryName))
//         .toList();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           categoryName,
//           style: Theme.of(context)
//               .textTheme
//               .headlineSmall!
//               .apply(color: isDark ? light : slate800, fontSizeFactor: 0.8),
//         ),
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: Icon(
//             Icons.arrow_back,
//             color: isDark ? light : slate800, // Change the color here
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         child: Obx(() {
//           if (productController.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final filteredProducts = productController.products
//               .where((product) => product.tags.contains(categoryName))
//               .toList();

//           return filteredProducts.isEmpty
//               ? const Center(child: Text("No items found in this category"))
//               : Padding(
//                   padding: const EdgeInsets.all(defaultSize),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           itemCount: filteredProducts.length,
//                           itemBuilder: (_, index) {
//                             final product = filteredProducts[index];
//                             return ProductCardHorizontal(product: product);
//                           },
//                           separatorBuilder: (_, __) =>
//                               const SizedBox(height: spaceBtwItems),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//         }),
//       ),
//     );
//   }
// }

import 'package:flourish/src/common_widget/product/product_card_horizontal.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryName;
  const SubCategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: isDark ? light : slate800, fontSizeFactor: 0.8),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? light : slate800,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (productController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredProducts = productController.products
            .where((product) => product.tags.contains(categoryName))
            .toList();

        return filteredProducts.isEmpty
            ? const Center(child: Text("No items found in this category"))
            : Padding(
                padding: const EdgeInsets.all(defaultSize),
                child: ListView.separated(
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, index) {
                    final product = filteredProducts[index];
                    return ProductCardHorizontal(product: product);
                  },
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: spaceBtwItems),
                ),
              );
      }),
    );
  }
}
