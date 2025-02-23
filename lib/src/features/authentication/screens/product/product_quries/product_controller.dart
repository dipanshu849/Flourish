import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:flourish/src/features/authentication/screens/product/product_quries/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepo = ProductRepository();
  final RxList<ProductModel> _products = <ProductModel>[].obs;
  final RxBool _isLoading = false.obs;

  // Getters for observable variables
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Upload product with images
  Future<void> uploadProduct({
    required String userId,
    required String title,
    required double price,
    double? discount,
    required String description,
    required List<XFile> imageFiles,
    required String condition,
    required List<String> tags,
    String status = "available",
  }) async {
    _isLoading.value = true;

    var uuid = const Uuid();
    String newId = uuid.v4();

    try {
      List<String> imageUrls = await _productRepo.uploadImages(imageFiles);
      ProductModel product = ProductModel(
        id: newId,
        sellerId: userId,
        title: title,
        price: price,
        discount: discount,
        description: description,
        imageUrl: imageUrls,
        condition: condition,
        tags: tags,
        createdAt: DateTime.now(),
      );

      await _productRepo.addProduct(product);
      _products.add(product);
      Get.snackbar("Success", "Product listed successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to list product: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  // Future<void> fetchProducts() async {
  //   try {
  //     _isLoading.value = true;
  //     final List<ProductModel> fetchedProducts =
  //         await _productRepo.getProducts();
  //     _products.assignAll(fetchedProducts); // Use assignAll to update RxList
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to fetch products: $e");
  //   } finally {
  //     _isLoading.value = false;
  //   }
  // }
  Future<void> fetchProducts() async {
    _isLoading.value = true;
    try {
      final fetchedProducts = await _productRepo.getProducts();
      if (fetchedProducts.isNotEmpty) {
        products.assignAll(fetchedProducts);
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      _isLoading.value = false;
    }
  }
}
