import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Focus
  final passwordFocusNode = FocusNode();

  // Visibility
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Show rules
  RxBool showPasswordRules = false.obs;

  // Rules
  RxBool hasUppercase = false.obs;
  RxBool hasNumber = false.obs;
  RxBool hasMinLength = false.obs;

  @override
  void onInit() {
    super.onInit();

    passwordFocusNode.addListener(() {
      showPasswordRules.value = passwordFocusNode.hasFocus;
    });
  }

  /// Password validation
  void validatePassword(String value) {
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasNumber.value = value.contains(RegExp(r'[0-9]'));
    hasMinLength.value = value.length >= 8;
  }

  /// Strength count (0–3)
  int get strengthCount {
    int count = 0;
    if (hasUppercase.value) count++;
    if (hasNumber.value) count++;
    if (hasMinLength.value) count++;
    return count;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}

// class AuthController extends GetxController {
//   // Controllers
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   // Focus
//   final passwordFocusNode = FocusNode();
//
//   // Visibility
//   RxBool isPasswordVisible = false.obs;
//   RxBool isConfirmPasswordVisible = false.obs;
//
//   // Show rules
//   RxBool showPasswordRules = false.obs;
//
//   // Rules
//   RxBool hasUppercase = false.obs;
//   RxBool hasNumber = false.obs;
//   RxBool hasMinLength = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     passwordFocusNode.addListener(() {
//       showPasswordRules.value = passwordFocusNode.hasFocus;
//     });
//   }
//
//   void validatePassword(String value) {
//     hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
//     hasNumber.value = value.contains(RegExp(r'[0-9]'));
//     hasMinLength.value = value.length >= 8;
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     passwordFocusNode.dispose();
//     super.onClose();
//   }
// }
