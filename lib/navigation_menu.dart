import 'package:flourish/src/features/authentication/screens/home/home.dart';
import 'package:flourish/src/features/authentication/screens/sell/sell.dart';
import 'package:flourish/src/features/authentication/screens/setting/setting.dart';
import 'package:flourish/src/features/authentication/screens/wishlist/wishlist.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = HelperFunction.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: isDark ? slate800 : light,
          indicatorColor:
              isDark ? dark.withOpacity(0.8) : slate400.withOpacity(0.8),
          destinations: [
            NavigationDestination(
                icon: Icon(
                  LineAwesomeIcons.home_solid,
                  color: isDark ? slate400 : dark,
                ),
                label: "Home"),
            NavigationDestination(
                icon: Icon(
                  LineAwesomeIcons.comments_solid,
                  color: isDark ? slate400 : dark,
                ),
                label: "Chat"),
            // NavigationDestination(
            //     icon: Icon(
            //       LineAwesomeIcons.plus_circle_solid,
            //       color: isDark ? slate400 : dark,
            //     ),
            //     label: "Sell"),
            NavigationDestination(
              icon: Container(
                width: 48, // Adjust size as needed
                height: 48,
                decoration: BoxDecoration(
                  color:
                      isDark ? dark : slate400, // Solid color without opacity
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LineAwesomeIcons.plus_circle_solid,
                  color:
                      isDark ? Colors.white : Colors.black, // Contrasting color
                  size: 24, // Adjust icon size as needed
                ),
              ),
              label: "Sell",
            ),
            NavigationDestination(
                icon: Icon(
                  LineAwesomeIcons.heart,
                  color: isDark ? slate400 : dark,
                ),
                label: "Wishlist"),
            NavigationDestination(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: isDark ? slate400 : dark,
                ),
                label: "Profile"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const HomeScreen(),
    ProductUploadPage(),
    // const ComplaintPage(),
    // const QRCodePage(),
    const WishlistScreen(),
    const ProfileScreen(),
    // const ProfileScreen(),d
  ];
}
