import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  // ChatController chatController = Get.find();

  var chats = [].obs; // Stores list of chats
  var messages = [].obs; // Stores messages for the active chat
  var isLoading = false.obs;

  // Fetch all chats for the current user
  // Future<void> fetchChats(String userId) async {
  //   isLoading.value = true;
  //   final response = await supabase
  //       .from('chats')
  //       .select()
  //       .or('buyer_id.eq.$userId,seller_id.eq.$userId')
  //       .order('updated_at', ascending: false);

  //   if (response.isNotEmpty) {
  //     chats.value = response;
  //   }
  //   isLoading.value = false;
  // }
  Future<void> fetchChats(String userId) async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('chats')
          .select('''
          *, 
          products:product_id (title),
          buyer:buyer_id (full_name, avatar_url),
          seller:seller_id (full_name, avatar_url)
        ''')
          .or('buyer_id.eq.$userId,seller_id.eq.$userId')
          .order('updated_at', ascending: false);

      chats.value = response ?? [];
    } catch (e) {
      Get.snackbar("Error", "Failed to load chats");
      chats.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch messages for a chat
  Future<void> fetchMessages(String chatId) async {
    isLoading.value = true;
    final response = await supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    messages.value = response;
    isLoading.value = false;
  }

  // Send a message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    final response = await supabase.from('messages').insert({
      'chat_id': chatId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
    });

    // Update last message in chats table
    await supabase.from('chats').update({
      'last_message': message,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', chatId);

    // Fetch updated messages
    fetchMessages(chatId);
  }

  // Create a new chat (if not exists)
  Future<String> createChat({
    required String productId,
    required String buyerId,
    required String sellerId,
  }) async {
    final existingChat = await supabase
        .from('chats')
        .select()
        .eq('product_id', productId)
        .eq('buyer_id', buyerId)
        .eq('seller_id', sellerId)
        .maybeSingle();

    if (existingChat != null) {
      return existingChat['id']; // Return existing chat ID
    }

    final response = await supabase.from('chats').insert({
      'product_id': productId,
      'buyer_id': buyerId,
      'seller_id': sellerId,
    }).select();

    return response[0]['id'];
  }

  Future<String?> initializeChat(
      String sellerId, String buyerId, String productId) async {
    try {
      // Prevent user from starting chat with themselves
      if (sellerId == buyerId) {
        return "Cannot start a chat with yourself";
      }

      // Check if chat already exists
      final existingChat = await supabase
          .from('chats')
          .select('id')
          .eq('product_id', productId)
          .eq('buyer_id', buyerId)
          .eq('seller_id', sellerId)
          .maybeSingle();

      if (existingChat != null) {
        return existingChat['id']; // Return existing chat ID
      }

      // If chat doesn't exist, create a new one
      final response = await supabase.from('chats').insert({
        'product_id': productId,
        'buyer_id': buyerId,
        'seller_id': sellerId,
        'last_message': '',
        'updated_at': DateTime.now().toIso8601String(),
      }).select();

      return response.isNotEmpty ? response[0]['id'] : null;
    } catch (e) {
      print("Error initializing chat: $e");
      return null;
    }
  }
}
