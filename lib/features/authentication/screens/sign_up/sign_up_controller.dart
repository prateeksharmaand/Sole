import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Password Strength State
  final hasUppercase = false.obs;
  final hasDigits = false.obs;
  final hasMinLength = false.obs;
  final passwordStrength = 0.0.obs; // 0.0 to 1.0

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updatePassword(String value) {
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasDigits.value = value.contains(RegExp(r'[0-9]'));
    hasMinLength.value = value.length >= 8;

    // Calculate strength
    int strengthCount = 0;
    if (hasUppercase.value) strengthCount++;
    if (hasDigits.value) strengthCount++;
    if (hasMinLength.value) strengthCount++;

    passwordStrength.value = strengthCount / 3;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
