import 'package:flourish/src/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flourish/src/utils/constants/image_strings.dart';
import 'package:flourish/src/utils/constants/sizes.dart';
import 'package:flourish/src/utils/constants/text_strings.dart';
import 'package:flourish/src/utils/device/device_utility.dart';
import 'package:flourish/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = HelperFunction.getScreenSize(context);
    final dark = HelperFunction.isDarkMode();
    final controller = Get.put(OnBoardingController());
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            // HORIZONTAL SCROLLABLE PAGES
            children: [
              OnBoardingPage(
                size: size,
                image: onboardingImage1,
                title: onBoardingTitle1,
                subtitle: onBoardingSubTitle1,
              ),
              OnBoardingPage(
                size: size,
                image: onboardingImage2,
                title: onBoardingTitle2,
                subtitle: onBoardingSubTitle2,
              ),
              OnBoardingPage(
                size: size,
                image: onboardingImage3,
                title: onBoardingTitle3,
                subtitle: onBoardingSubTitle3,
              ),
              OnBoardingPage(
                size: size,
                image: onboardingImage4,
                title: onBoardingTitle4,
                subtitle: onBoardingSubTitle4,
              ),
            ],
          ),

          // SKIP BUTTON
          Positioned(
              right: defaultSize * 0.5,
              child: TextButton(
                  onPressed: () => controller.onSkipPage(),
                  child: const Text("Skip"))),

          // DOT NAVIGATINO
          Positioned(
              bottom: DeviceUtility.getBottomNavigationBarHeight(context) + 25,
              left: defaultSize,
              child: SmoothPageIndicator(
                controller: controller.pageController,
                onDotClicked: controller.onDotNavigationTap,
                count: 4,
                effect: ExpandingDotsEffect(
                    activeDotColor: dark ? slate400 : slate800, dotHeight: 6),
              )),

          // NEXT BUTTON
          Positioned(
              bottom: DeviceUtility.getBottomNavigationBarHeight(context) + 20,
              right: defaultSize * 0.5,
              child: ElevatedButton(
                  onPressed: () => controller.onNextPage(),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded)))
        ],
      ),
    ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final Size size;
  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultSize),
      child: Column(
        children: [
          Image(
            height: size.height * 0.6,
            width: size.width * 0.8,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
