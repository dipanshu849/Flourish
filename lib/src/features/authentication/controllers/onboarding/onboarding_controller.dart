import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();

  final RxInt _currentPage = 0.obs;
  final RxBool _isLastPage = false.obs;

  int get currentPage => _currentPage.value;
  bool get isLastPage => _isLastPage.value;

  void onPageChanged(index) {
    _currentPage.value = index;
    _isLastPage.value = index == 4;
  }

  void onDotNavigationTap(int index) {
    _currentPage.value = index;
    pageController.jumpToPage(_currentPage.value);
  }

  /// Goes to the next page if the current page is not the last page.
  ///
  /// If the current page is the last page, this function does nothing.

  void onNextPage() {
    if (_currentPage.value < 4) {
      _currentPage.value++;
      pageController.jumpToPage(_currentPage.value);
    }
  }

  void onSkipPage() {
    _currentPage.value = 4;
    pageController.jumpToPage(_currentPage.value);
  }
}
