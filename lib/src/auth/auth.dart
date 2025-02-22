import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  /// Sign Up User
  Future<String?> signUp(String email, String password, String fullName) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Add user details to users table
      await supabase.from('users').insert({
        'id': response.user?.id,
        'email': email,
        'full_name': fullName,
      });

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Sign In User
  Future<String?> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Sign Out User
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  /// Get Current User ID
  String? getUserId() {
    return supabase.auth.currentUser?.id;
  }

  /// Post a Product
  Future<String?> postProduct({
    required String title,
    required String description,
    required double price,
    required String category,
    required List<String> tags,
    required List<String> imageUrls,
  }) async {
    try {
      final userId = getUserId();
      if (userId == null) return "User not logged in";

      await supabase.from('products').insert({
        'seller_id': userId,
        'title': title,
        'description': description,
        'price': price,
        'category': category,
        'tags': tags,
        'image_url': imageUrls,
      });

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Fetch Products
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabase
        .from('products')
        .select()
        .order('created_at', ascending: false);
    return response;
  }

  /// Add Item to Wishlist
  Future<String?> addToWishlist(String productId) async {
    try {
      final userId = getUserId();
      if (userId == null) return "User not logged in";

      await supabase
          .from('wishlist')
          .insert({'user_id': userId, 'product_id': productId});
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Fetch Wishlist Items
  Future<List<Map<String, dynamic>>> fetchWishlist() async {
    final userId = getUserId();
    if (userId == null) return [];

    final response =
        await supabase.from('wishlist').select().eq('user_id', userId);
    return response;
  }

  /// Initialize Chat Between Users
  Future<String?> startChat(String receiverId) async {
    try {
      final userId = getUserId();
      if (userId == null) return "User not logged in";

      final chat = await supabase.from('chats').insert({
        'user1': userId,
        'user2': receiverId,
      }).select();

      return chat.first['id']; // Return chat ID
    } catch (e) {
      return e.toString();
    }
  }

  /// Fetch Chat Messages
  Future<List<Map<String, dynamic>>> fetchMessages(String chatId) async {
    final response = await supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);
    return response;
  }

  /// Send Message
  Future<String?> sendMessage(String chatId, String message) async {
    try {
      final userId = getUserId();
      if (userId == null) return "User not logged in";

      await supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': userId,
        'message': message,
      });

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
}
