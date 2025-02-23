import 'package:supabase_flutter/supabase_flutter.dart';

class MessagingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch messages for a chat
  Future<List<Map<String, dynamic>>> fetchMessages(String chatId) async {
    final response = await _supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('timestamp', ascending: true);

    return response;
  }

  /// Send a message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _supabase.from('messages').insert({
      'chat_id': chatId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Listen for real-time messages
  Stream<List<Map<String, dynamic>>> listenForMessages(String chatId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id']).eq('chat_id', chatId);
  }
}
