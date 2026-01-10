import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/services/auth_storage_service.dart';
import '../../../../data/models/user_model.dart';
import '../../../../routes/routes.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorageService _authStorage = AuthStorageService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();
  final couponCodeController = TextEditingController(text: 'Ek2oey67');

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final selectedJoinFrom = ''.obs;

  // Password Strength State
  final hasUppercase = false.obs;
  final hasDigits = false.obs;
  final hasMinLength = false.obs;
  final passwordStrength = 0.0.obs; // 0.0 to 1.0

  // Validation errors
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;
  final joinFromError = ''.obs;

  // Loading state
  final isLoading = false.obs;

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

  /// Validate form fields
  bool validateFields() {
    // Clear previous errors
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    joinFromError.value = '';

    bool isValid = true;

    // Email validation
    if (emailController.text.trim().isEmpty) {
      emailError.value = 'Please enter your email';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Please enter a password';
      isValid = false;
    } else if (!hasUppercase.value || !hasDigits.value || !hasMinLength.value) {
      passwordError.value = 'Password must meet all requirements';
      isValid = false;
    }

    // Confirm password validation
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      isValid = false;
    } else if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    // Join from validation
    if (selectedJoinFrom.value.isEmpty) {
      joinFromError.value = 'Please select where you joined from';
      isValid = false;
    }

    return isValid;
  }

  /// Register user
  Future<bool> registerUser() async {
    isLoading.value = true;

    try {
      // Get device_id from storage
      final storage = GetStorage();
      final deviceId = storage.read('device_id') as int?;

      if (deviceId == null) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Device not registered. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final response = await _authRepository.register(
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        deviceId: deviceId,
        referralCode: referralCodeController.text.trim(),
        couponCode: couponCodeController.text.trim(),
      );

      isLoading.value = false;

      if (response.success && response.data != null) {
        // Extract user data from response
        final userData = response.data!['data']?['user'];

        if (userData != null) {
          // Create UserModel from response data
          final user = UserModel.fromJson(userData);

          // Save token and user data using AuthStorageService
          await _authStorage.saveToken(user.token);
          await _authStorage.saveUser(user);

          print('✅ Registration successful. User logged in.');

          Get.snackbar(
            'Success',
            response.message ?? 'Registration successful',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Navigate to dashboard
          Get.offAllNamed(URoutes.dashboard);

          return true;
        } else {
          // User data is null
          Get.snackbar(
            'Error',
            'Failed to retrieve user data',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Registration failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      print('⚠️ Registration error: $e');
      Get.snackbar(
        'Error',
        'Registration failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralCodeController.dispose();
    couponCodeController.dispose();
    super.onClose();
  }
}
