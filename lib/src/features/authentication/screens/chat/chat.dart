import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/features/authentication/screens/chat/chat_query/chat_controller.dart';
import 'package:flourish/src/features/authentication/screens/chat/recent_chat.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/circular_container.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'chat_tabs.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ChatController chatController = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());
  late String? currentUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    currentUserId = authController.currentUserId;
    _initializeChats();
  }

  Future<void> _initializeChats() async {
    if (currentUserId != null) {
      await chatController.fetchChats(currentUserId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = HelperFunction.getScreenSize(context);

    return Scaffold(
      backgroundColor: light,
      body: Column(
        children: [
          CurvedEdgeWidget(
            child: Container(
              color: slate400,
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: size.height * 0.135,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: -150,
                      right: -250,
                      child: CircularContainer(
                          backgroundColor: light.withOpacity(0.1)),
                    ),
                    Positioned(
                      top: 100,
                      right: -300,
                      child: CircularContainer(
                          backgroundColor: light.withOpacity(0.1)),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        title: Text(
                          "Chats",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: slate800, fontSizeFactor: 0.8),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            if (chatController.isLoading.value) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (currentUserId == null) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Please login to view chats"),
              );
            }

            if (chatController.chats.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No recent chats found"),
              );
            }

            return RecentChatsSection(
              chats: chatController.chats,
              currentUserId: currentUserId!,
            );
          }),
          Expanded(
            child: ChatTabSection(
              tabController: _tabController,
              allChats: chatController.chats,
              currentUserId: currentUserId!,
            ),
          ),
        ],
      ),
    );
  }
}
