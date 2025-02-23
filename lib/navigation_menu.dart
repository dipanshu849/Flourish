// import 'package:flourish/src/features/authentication/screens/chat/chat.dart';
import 'package:flourish/src/features/authentication/screens/chat/chat.dart';
import 'package:flourish/src/features/authentication/screens/home/home.dart';
import 'package:flourish/src/features/authentication/screens/sell/sell.dart';
import 'package:flourish/src/features/authentication/screens/setting/setting.dart';
import 'package:flourish/src/features/authentication/screens/wishlist/wishlist.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// Custom painter for smooth curves
class SmoothNavBarPainter extends CustomPainter {
  final Color color;

  SmoothNavBarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Starting point
    path.moveTo(0, 0);

    // Left side
    path.lineTo(0, size.height);

    // Bottom
    path.lineTo(size.width, size.height);

    // Right side
    path.lineTo(size.width, 0);

    // Top curve around the center
    path.lineTo((size.width + 35) / 2, 0);
    path.quadraticBezierTo(size.width / 2, -15, (size.width - 35) / 2, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = HelperFunction.isDarkMode(context);

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          height: 80, // Fixed height for bottom nav
          child: Stack(
            fit: StackFit.expand, // Makes stack fill its container
            clipBehavior: Clip.none, // Allows sell button to overflow upwards
            children: [
              // Background and main nav items
              CustomPaint(
                painter: SmoothNavBarPainter(isDark ? slate800 : Colors.white),
                child: Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildNavItem(0, LineAwesomeIcons.home_solid,
                              'HOME', controller, isDark)),
                      Expanded(
                          child: _buildNavItem(
                              1,
                              LineAwesomeIcons.comments_solid,
                              'CHATS',
                              controller,
                              isDark)),
                      const Expanded(
                          child: SizedBox(
                              width: 70)), // Placeholder for center button
                      Expanded(
                          child: _buildNavItem(3, LineAwesomeIcons.heart,
                              'WISHLIST', controller, isDark)),
                      Expanded(
                          child: _buildNavItem(4, Icons.person_2_outlined,
                              'ACCOUNT', controller, isDark)),
                    ],
                  ),
                ),
              ),
              // Centered sell button
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.selectedIndex.value = 2,
                    child: SizedBox(
                      width: 70,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(
                              begin: 1,
                              end: controller.selectedIndex.value == 2
                                  ? 0.95
                                  : 1,
                            ),
                            duration: const Duration(milliseconds: 200),
                            builder: (context, double scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.cyan],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                        spreadRadius: 2,
                                      ),
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.2),
                                        blurRadius: 12,
                                        offset: const Offset(0, -2),
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'SELL',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label,
      NavigationController controller, bool isDark) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.selectedIndex.value = index,
      child: Container(
        height: 80, // Match parent height
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1, end: isSelected ? 1.1 : 1),
          duration: const Duration(milliseconds: 200),
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? isDark
                            ? Colors.white
                            : Colors.black
                        : isDark
                            ? slate400
                            : Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? isDark
                              ? Colors.white
                              : Colors.black
                          : isDark
                              ? slate400
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    // const HomeScreen(),
    ChatScreen(),
    ProductUploadPage(),
    // const ComplaintPage(),
    // const QRCodePage(),
    const WishlistScreen(),
    ProfileScreen(),
    // const ProfileScreen(),d
  ];
}
