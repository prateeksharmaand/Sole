import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/features/authentication/screens/login/login_screen.dart';

class OnboardingController extends GetxController{
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  // page change track
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // Next button logic
  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAll(LoginScreen()); // ya home
    }
  }
  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  // Skip onboarding
  void skip() {
    // Directly go to last page (page 2)
    pageController.animateToPage(
      2, // last page index
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}