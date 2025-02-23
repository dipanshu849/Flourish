import 'package:flourish/src/auth/auth_controller.dart';
import 'package:flourish/src/common_widget/btn/loading_button.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/circular_container.dart';
import 'package:flourish/src/features/authentication/screens/home/widget/curved_edge_widget.dart';
import 'package:flourish/src/features/authentication/screens/onboarding.dart';
import 'package:flourish/src/features/authentication/screens/orders/orders.dart';
import 'package:flourish/src/features/authentication/screens/setting/setting_controller.dart';
import 'package:flourish/src/features/authentication/screens/setting/setting_menu_tile.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final RxBool isLoggingOut = false.obs;
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final Size size = HelperFunction.getScreenSize(context);
    final isDark = HelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
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
                      // app bar
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          title: Text(
                            "Account",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(color: slate800, fontSizeFactor: 0.8),
                            // style: TextStyle(
                            //     fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                    ],
                    // user profile card
                  ),
                ),
              ),
            ),

            // BODY
            Padding(
                padding: const EdgeInsets.all(defaultSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Icon(
                        Icons.person_2_rounded,
                        size: 120,
                        color: isDark ? light : dark,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                controller.userName.value.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: slate600),
                              ),
                            ),
                            Text(
                              controller.userEmail.value,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    // const SettingMenuTile(
                    //   title: "Purchases",
                    //   icon: Icons.history,
                    // ),
                    SettingMenuTile(
                      title: "Products",
                      icon: Icons.list,
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),
                    GetBuilder<SettingsController>(
                      builder: (controller) => Column(
                        children: [
                          SettingMenuTile(
                            title: "Notifications",
                            icon: Icons.notifications,
                            trailing: Obx(
                              () => Switch(
                                value: controller.notificationsEnabled.value,
                                onChanged: (value) async {
                                  await controller
                                      .updateNotificationSetting(value);
                                  // Force UI update
                                  controller.update();
                                },
                                inactiveThumbColor: slate600,
                                inactiveTrackColor: light,
                                activeTrackColor: slate400,
                                trackOutlineColor:
                                    const WidgetStatePropertyAll(slate400),
                              ),
                            ),
                          ),
                          SettingMenuTile(
                            title: "Dark Mode",
                            icon: Icons.dark_mode,
                            trailing: Obx(
                              () => Switch(
                                value: controller.darkModeEnabled.value,
                                onChanged: controller.toggleDarkMode,
                                inactiveThumbColor: slate600,
                                inactiveTrackColor: light,
                                activeTrackColor: slate400,
                                trackOutlineColor:
                                    const WidgetStatePropertyAll(slate400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => LoadingButton(
                          onPressed: () async {
                            await controller.logoutUser(isLoggingOut);
                            Get.offAll(() =>
                                const OnBoardingScreen()); // Redirect to login
                          },
                          isLoading: isLoggingOut.value,
                          text: "Logout",
                        ))
                  ],
                ))

            // BODY
          ],
        ),
      ),
    );
  }
}
