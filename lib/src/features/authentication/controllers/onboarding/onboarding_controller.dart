import 'package:flourish/src/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();

  final RxInt _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  void onPageChanged(index) {
    _currentPage.value = index;
  }

  void onDotNavigationTap(index) {
    _currentPage.value = index;
    pageController.jumpToPage(_currentPage.value);
  }

  /// Goes to the next page if the current page is not the last page.
  ///
  /// If the current page is the last page, this function does nothing.

  void onNextPage() {
    if (_currentPage.value < 3) {
      _currentPage.value++;
      pageController.jumpToPage(_currentPage.value);
    } else if (_currentPage.value == 3) {
      Get.offAll(const LoginScreen());
    }
  }

  void onSkipPage() {
    _currentPage.value = 3;
    pageController.jumpToPage(_currentPage.value);
  }
}
