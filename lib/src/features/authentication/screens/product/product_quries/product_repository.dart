import 'package:flourish/src/features/authentication/screens/product/product_quries/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<String>> uploadImages(List<XFile> imageFiles) async {
    List<String> imageUrls = [];

    for (XFile image in imageFiles) {
      try {
        final bytes = await image.readAsBytes();
        final fileName =
            'products/${DateTime.now().millisecondsSinceEpoch}_${image.name}';

        // Upload image to Supabase Storage
        final uploadedPath = await _supabase.storage
            .from('product-images') // Change to your bucket name
            .uploadBinary(fileName, bytes);

        // Get the public URL of the uploaded image
        final url =
            _supabase.storage.from('product-images').getPublicUrl(fileName);
        imageUrls.add(url);
      } catch (e) {}
    }
    return imageUrls;
  }

  // Add new product
  Future<void> addProduct(ProductModel product) async {
    try {
      await _supabase.from('products').insert({
        'id': product.id,
        'seller_id': product.sellerId,
        'title': product.title,
        'price': product.price,
        'discount': product.discount,
        'description': product.description,
        'image_url': '{${product.imageUrl.join(",")}}',
        'condition': product.condition,
        'tags': product.tags,
        'created_at': product.createdAt.toIso8601String(),
      });
    } catch (e) {
      throw Exception("Failed to add product: $e");
    }
  }

  // Fetch all products
  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await _supabase.from('products').select();
    return response.map((data) => ProductModel.fromJson(data)).toList();
  }

  // Fetch products by user
  Future<List<ProductModel>> fetchUserProducts(String userId) async {
    final response =
        await _supabase.from('products').select().eq('user_id', userId);
    return response.map((data) => ProductModel.fromJson(data)).toList();
  }

  // Future<List<ProductModel>> getProducts() async {
  //   final response = await _supabase.from('products').select();

  //   return response
  //       .map<ProductModel>((json) => ProductModel.fromJson(json))
  //       .toList();
  // }

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _supabase
          .from('products')
          .select()
          .order('created_at', ascending: false);

      return response
          .map<ProductModel>((data) => ProductModel.fromJson(data))
          .toList();
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
