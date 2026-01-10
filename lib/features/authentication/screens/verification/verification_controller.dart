import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/routes/routes.dart';
import '../../../../data/repositories/auth_repository.dart';

class VerificationController extends GetxController {
  final otpController = TextEditingController();
  final email = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get email from arguments
    email.value = Get.arguments as String? ?? '';
  }

  /// Verify account with OTP
  Future<void> verifyAccount() async {
    if (otpController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the verification code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final authRepo = AuthRepository();
      final response = await authRepo.activateAccount(
        email: email.value,
        token: otpController.text.trim(),
      );

      isLoading.value = false;

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message ?? 'Account verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(URoutes.dashboard);
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Verification failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Verification failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
