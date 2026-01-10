import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/data/repositories/auth_repository.dart';
import 'package:sole/data/services/auth_storage_service.dart';
import 'package:sole/routes/routes.dart';
import 'package:sole/utils/constants/colors.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorageService _authStorage = AuthStorageService();

  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable states
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  // Validation errors
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Validate email format
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Basic email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validate password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Login user
  Future<void> login() async {
    // Clear previous errors
    emailError.value = '';
    passwordError.value = '';

    // Validate fields
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    bool isValid = true;

    // Email validation
    if (email.isEmpty) {
      emailError.value = 'Please enter your email';
      isValid = false;
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emailError.value = 'Please enter a valid email';
        isValid = false;
      }
    }

    // Password validation
    if (password.isEmpty) {
      passwordError.value = 'Please enter your password';
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    // Stop if validation failed
    if (!isValid) {
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Call login API
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        final loginResponse = response.data!;

        if (loginResponse.user != null) {
          // Save token and user data
          await _authStorage.saveToken(loginResponse.user!.token);
          await _authStorage.saveUser(loginResponse.user!);

          // Show success message
          Get.snackbar(
            'Success',
            response.message ?? 'Login successful',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: UColors.primary,
            colorText: UColors.white,
            duration: const Duration(seconds: 2),
          );

          // Navigate to dashboard
          Get.offAllNamed(URoutes.dashboard);
        } else {
          // User data is null
          Get.snackbar(
            'Error',
            'Failed to retrieve user data',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: UColors.error,
            colorText: UColors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        // Login failed
        Get.snackbar(
          'Login Failed',
          response.message ?? 'Incorrect email address or password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: UColors.error,
          colorText: UColors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: UColors.error,
        colorText: UColors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }
}
