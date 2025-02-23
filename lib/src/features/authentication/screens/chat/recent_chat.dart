import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:get/get.dart';

class RecentChatsSection extends StatelessWidget {
  final List<dynamic> chats;
  final String currentUserId;

  const RecentChatsSection({
    Key? key,
    required this.chats,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Recent Chats',
              style: Theme.of(context).textTheme.titleMedium?.apply(
                    color: slate800,
                    fontWeightDelta: 2,
                  ),
            ),
            if (chats.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: Text("No conversations yet")),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: spaceBtwItems,
                  crossAxisSpacing: spaceBtwItems,
                  mainAxisExtent: 110,
                ),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return RecentChatTile(
                    chat: chat,
                    currentUserId: currentUserId,
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}

class RecentChatTile extends StatefulWidget {
  final dynamic chat;
  final String currentUserId;

  const RecentChatTile({
    Key? key,
    required this.chat,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<RecentChatTile> createState() => _RecentChatTileState();
}

class _RecentChatTileState extends State<RecentChatTile> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: slate400.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slate800.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(defaultSize / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
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
              const SizedBox(width: spaceBtwItems / 2),
              Flexible(
                child: Text(
                  isLoading ? 'Loading...' : otherUserName ?? 'User',
                  style: Theme.of(context).textTheme.titleMedium?.apply(
                        color: slate800,
                        fontWeightDelta: 1,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: spaceBtwItems / 2),
          Text(
            itemName,
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: slate600,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            lastMessage,
            style: Theme.of(context).textTheme.bodySmall?.apply(
                  color: slate600.withOpacity(0.8),
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
