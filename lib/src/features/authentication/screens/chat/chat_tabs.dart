//

import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ChatTabSection extends StatelessWidget {
  final TabController tabController;
  final List<dynamic> allChats;
  final String currentUserId;

  // @override
  // Widget build(BuildContext context) => Container();

  const ChatTabSection({
    Key? key,
    required this.tabController,
    required this.allChats,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: light,
            border: Border(
              bottom: BorderSide(
                color: slate400.withOpacity(0.2),
              ),
            ),
          ),
          child: TabBar(
            controller: tabController,
            labelColor: slate800,
            unselectedLabelColor: slate600.withOpacity(0.6),
            indicatorColor: rose,
            tabs: const [
              Tab(text: 'ALL'),
              Tab(text: 'BUYING'),
              Tab(text: 'SELLING'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              ChatList(chats: allChats, currentUserId: currentUserId),
              ChatList(
                chats: allChats
                    .where((chat) => chat['buyer_id'] == currentUserId)
                    .toList(),
                currentUserId: currentUserId,
              ),
              ChatList(
                chats: allChats
                    .where((chat) => chat['seller_id'] == currentUserId)
                    .toList(),
                currentUserId: currentUserId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatList extends StatelessWidget {
  final List<dynamic> chats;
  final String currentUserId;

  const ChatList({
    Key? key,
    required this.chats,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chats.isEmpty) {
      return Center(
        child: Text(
          'No chats found',
          style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: slate600,
              ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(defaultSize),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListTile(
          chat: chat,
          currentUserId: currentUserId,
        );
      },
    );
  }
}

class ChatListTile extends StatefulWidget {
  final dynamic chat;
  final String currentUserId;

  const ChatListTile({
    Key? key,
    required this.chat,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  String? otherUserName;
  bool isLoading = true;

  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final String otherUserId = widget.currentUserId == widget.chat['buyer_id']
          ? widget.chat['seller_id']
          : widget.chat['buyer_id'];

      final userData = await authController.fetchUserDetail(otherUserId);
      if (mounted) {
        setState(() {
          otherUserName = userData?['full_name'] ?? 'User';
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      if (mounted) {
        setState(() {
          otherUserName = 'User';
          isLoading = false;
        });
      }
    }
  }

  String get chatType {
    return widget.currentUserId == widget.chat['buyer_id']
        ? 'buying'
        : 'selling';
  }

  String get itemName {
    try {
      final products = widget.chat['products'];
      if (products is Map) {
        return products['title']?.toString() ?? 'Product';
      }
      return 'Product';
    } catch (e) {
      debugPrint('Error getting item name: $e');
      return 'Product';
    }
  }

  String get firstLetter {
    return otherUserName?.isNotEmpty == true
        ? otherUserName![0].toUpperCase()
        : '?';
  }

  String get lastMessage {
    return widget.chat['last_message']?.toString() ?? '';
  }

  String get category {
    try {
      final products = widget.chat['products'];
      if (products is Map) {
        return products['category']?.toString() ?? '';
      }
      return '';
    } catch (e) {
      debugPrint('Error getting category: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: spaceBtwItems),
      decoration: BoxDecoration(
        color: slate400.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: slate800.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(defaultSize / 2),
        leading: CircleAvatar(
          backgroundColor: chatType == 'buying'
              ? rose.withOpacity(0.1)
              : slate600.withOpacity(0.1),
          child: isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: chatType == 'buying' ? rose : slate600,
                  ),
                )
              : Text(
                  firstLetter,
                  style: TextStyle(
                    color: chatType == 'buying' ? rose : slate600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        title: Text(
          isLoading ? 'Loading...' : otherUserName ?? 'User',
          style: Theme.of(context).textTheme.titleMedium?.apply(
                color: slate800,
                fontWeightDelta: 2,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    itemName,
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: slate600,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (category.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: slate600.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.bodySmall?.apply(
                            color: slate600,
                          ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Text(
              lastMessage,
              style: Theme.of(context).textTheme.bodySmall?.apply(
                    color: slate600.withOpacity(0.8),
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultSize / 2,
            vertical: defaultSize / 4,
          ),
          decoration: BoxDecoration(
            color: chatType == 'buying'
                ? rose.withOpacity(0.1)
                : slate600.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            chatType.toUpperCase(),
            style: TextStyle(
              color: chatType == 'buying' ? rose : slate600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
