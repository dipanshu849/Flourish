import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Message {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}

class MessageScreen extends StatefulWidget {
  final String chatId;
  final String otherUserId;
  final String currentUserName;

  const MessageScreen({
    Key? key,
    required this.chatId,
    required this.otherUserId,
    required this.currentUserName,
  }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();

    // Auto focus the text field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _initializeData();
    });
    _fetchMessages();
    _listenForNewMessages(); // Call the function here
  }

  Future<void> _initializeData() async {
    try {
      await _fetchMessages();
      _listenForNewMessages();
    } catch (e) {
      print("Initialization error: $e");
    }
  }

  // void _listenForNewMessages() {
  //   Supabase.instance.client
  //       .from('messages')
  //       .stream(primaryKey: ['id'])
  //       .eq('chat_id', widget.chatId)
  //       .listen((data) {
  //         if (data.isNotEmpty) {
  //           setState(() {
  //             _messages.add(Message(
  //               text: data.last['message'],
  //               isSentByMe: data.last['sender_id'] ==
  //                   Supabase.instance.client.auth.currentUser!.id,
  //               timestamp: DateTime.parse(data.last['timestamp']),
  //             ));
  //           });
  //           _scrollToBottom();
  //         }
  //       });

  // }
  void _listenForNewMessages() {
    Supabase.instance.client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', widget.chatId)
        .listen((data) {
          if (data.isNotEmpty) {
            final newMessage = data.last;
            // Add message only if it doesn't exist already
            if (!_messages.any((m) =>
                m.timestamp == DateTime.parse(newMessage['timestamp']))) {
              setState(() {
                _messages.add(Message(
                  text: newMessage['message'],
                  isSentByMe: newMessage['sender_id'] ==
                      Supabase.instance.client.auth.currentUser!.id,
                  timestamp: DateTime.parse(newMessage['timestamp']),
                ));
              });
              _scrollToBottom();
            }
          }
        });
  }

  // Future<void> _fetchMessages() async {
  //   final response = await Supabase.instance.client
  //       .from('messages')
  //       .select()
  //       .eq('chat_id', widget.chatId)
  //       .order('timestamp', ascending: true);

  //   if (response != null) {
  //     setState(() {
  //       _messages = response
  //           .map<Message>((msg) => Message(
  //                 text: msg['message'],
  //                 isSentByMe: msg['sender_id'] ==
  //                     Supabase.instance.client.auth.currentUser!.id,
  //                 timestamp: DateTime.parse(msg['timestamp']),
  //               ))
  //           .toList();
  //     });
  //   }
  // }
  Future<void> _fetchMessages() async {
    try {
      final response = await Supabase.instance.client
          .from('messages')
          .select()
          .eq('chat_id', widget.chatId)
          .order('timestamp', ascending: true);

      if (response != null) {
        setState(() {
          _messages = response
              .map<Message>((msg) => Message(
                    text: msg['message'],
                    isSentByMe: msg['sender_id'] ==
                        Supabase.instance.client.auth.currentUser!.id,
                    timestamp: DateTime.parse(msg['timestamp']),
                  ))
              .toList();
        });
        _scrollToBottom();
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  void _handleSendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      final String senderId = Supabase.instance.client.auth.currentUser!.id;
      // final String receiverId = senderId == widget.otherUserId
      //     ? widget.currentUserName
      //     : widget.otherUserId;
      final String receiverId = widget.otherUserId;
      final DateTime timestamp = DateTime.now();

      try {
        await Supabase.instance.client.from('messages').insert({
          'chat_id': widget.chatId,
          'sender_id': senderId,
          'receiver_id': receiverId,
          'message': messageText,
          'timestamp':
              timestamp.toIso8601String(), // Convert DateTime to String
        });

        // Add message to UI
        setState(() {
          _messages.add(Message(
            text: messageText,
            isSentByMe: true,
            timestamp: timestamp,
          ));
        });

        await Supabase.instance.client.from('chats').update({
          'last_message': messageText,
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('id', widget.chatId);

        _messageController.clear();
        _scrollToBottom();
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF0F0F0),
              child: Text(
                widget.currentUserName[0].toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF808080),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.currentUserName,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2B2B2B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF2B2B2B)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Align(
                    alignment: message.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: message.isSentByMe
                            ? const Color(0xFF808080)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(
                            message.isSentByMe ? 20 : 4,
                          ),
                          bottomRight: Radius.circular(
                            message.isSentByMe ? 4 : 20,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(
                              color: message.isSentByMe
                                  ? Colors.white
                                  : const Color(0xFF2B2B2B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('hh:mm a').format(message.timestamp),
                            style: TextStyle(
                              fontSize: 10,
                              color: message.isSentByMe
                                  ? Colors.white.withOpacity(0.7)
                                  : const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F6FA),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _handleSendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF808080),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _handleSendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
