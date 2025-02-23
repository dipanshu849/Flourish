import 'package:flourish/src/features/authentication/screens/product/product_quries/product_controller.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    final userId = Supabase.instance.client.auth.currentUser?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: isDark ? light : slate800,
                fontSizeFactor: 0.8,
              ),
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
      body: FutureBuilder(
        future: Get.find<ProductController>().fetchSellerProducts(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = Get.find<ProductController>().products;

          if (products.isEmpty) {
            return Center(
              child: Text(
                'No products listed yet!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(defaultSize),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _ProductItemCard(product: product);
            },
          );
        },
      ),
    );
  }
}

class _ProductItemCard extends StatelessWidget {
  final ProductModel product;

  const _ProductItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slate400, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: defaultSize),
      child: Padding(
        padding: const EdgeInsets.all(defaultSize / 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            if (product.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.imageUrl.first,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(width: defaultSize),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: slate400,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _StatusChip(condition: product.condition),
                      const Spacer(),
                      Text(
                        DateFormat('MMM dd, yyyy').format(product.createdAt),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String condition;

  const _StatusChip({required this.condition});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (condition.toLowerCase()) {
      case 'available':
        backgroundColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
        break;
      case 'sold':
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
        break;
      case 'pending':
        backgroundColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        condition.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
