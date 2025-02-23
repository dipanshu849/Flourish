// wishlist_controller.dart
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final RxList<Map<String, dynamic>> wishlistItems =
      <Map<String, dynamic>>[].obs;

  // Future<void> fetchWishlist() async {
  //   final userId = _supabase.auth.currentUser?.id;
  //   if (userId == null) return;

  //   final response = await _supabase
  //       .from('wishlist')
  //       .select('''*, products(*)''')
  //       .eq('user_id', userId)
  //       .order('created_at', ascending: false);

  //   wishlistItems.value = List<Map<String, dynamic>>.from(response);
  // }
  Future<void> fetchWishlist() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('wishlist')
          .select('''*, products(*)''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      wishlistItems.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Fetch wishlist error: $e");
    }
  }

  // Future<void> toggleWishlist(String productId) async {
  //   final userId = _supabase.auth.currentUser?.id;
  //   if (userId == null) return;

  //   // Check if already in wishlist
  //   final response = await _supabase
  //       .from('wishlist')
  //       .select()
  //       .eq('user_id', userId)
  //       .eq('product_id', productId);

  //   final existing = response.isNotEmpty ? response.first : null;

  //   if (existing != null) {
  //     // Remove from wishlist
  //     await _supabase.from('wishlist').delete().eq('id', existing['id']);
  //   } else {
  //     // Add to wishlist
  //     await _supabase.from('wishlist').insert({
  //       'user_id': userId,
  //       'product_id': productId,
  //     });
  //   }

  //   await fetchWishlist();
  // }

  Future<void> toggleWishlist(String productId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      // Check existing entry
      final response = await _supabase
          .from('wishlist')
          .select()
          .eq('user_id', userId)
          .eq('product_id', productId);

      if (response.isNotEmpty) {
        // Remove from wishlist
        await _supabase
            .from('wishlist')
            .delete()
            .eq('id', response.first['id']);
      } else {
        // Add to wishlist
        await _supabase.from('wishlist').insert({
          'user_id': userId,
          'product_id': productId,
        });
      }

      await fetchWishlist();
    } catch (e) {
      print("Wishlist error: $e");
    }
  }
}
