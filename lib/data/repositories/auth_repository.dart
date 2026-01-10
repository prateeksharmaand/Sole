import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/user_model.dart';
import '../services/device_info_service.dart';
import '../../utils/constants/apis.dart';

/// Example Authentication Repository
/// Demonstrates how to use ApiClient in repositories
class AuthRepository {
  final ApiClient _apiClient = ApiClient();
  final DeviceInfoService _deviceInfoService = DeviceInfoService();

  /// Login with email and password
  Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Get device ID from storage (should be set during app initialization)
      final deviceId = GetStorage().read<int>('device_id') ?? 0;

      // Create form data to match API requirements
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        'signup_source': '1', // 1 for app
        'device_id': deviceId.toString(),
      });

      final response = await _apiClient.post(UApiUrls.login, data: formData);

      // Parse response into LoginResponse model
      final loginResponse = LoginResponse.fromJson(response.data);

      if (loginResponse.success && loginResponse.user != null) {
        return ApiResponse.success(
          loginResponse,
          message: loginResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          loginResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'An unexpected error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Register new user
  Future<ApiResponse<Map<String, dynamic>>> register({
    required String email,
    required String password,
    required String confirmPassword,
    required int deviceId,
    String? referralCode,
    String? couponCode,
  }) async {
    try {
      // Get platform
      final platform = _deviceInfoService.getPlatform();

      // Create form data
      final formData = FormData.fromMap({
        'email': email,
        'signup_source': '1', // 1 for app signup
        'device_id': deviceId.toString(),
        'password': password,
        'confirm_password': confirmPassword,
        'platform': await platform,
        if (referralCode != null && referralCode.isNotEmpty)
          'referral_code': referralCode,
        if (couponCode != null && couponCode.isNotEmpty)
          'coupon_code': couponCode,
      });

      final response = await _apiClient.post(UApiUrls.signup, data: formData);

      // Check if the API response indicates success
      final responseData = response.data as Map<String, dynamic>;
      final isSuccess = responseData['success'] ?? false;

      if (isSuccess) {
        return ApiResponse.success(
          responseData,
          message: responseData['message'] ?? 'Registration successful',
          statusCode: response.statusCode,
        );
      } else {
        // API returned success: false (e.g., invalid coupon code)
        return ApiResponse.error(
          responseData['message'] ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'An unexpected error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Logout user
  Future<ApiResponse<void>> logout() async {
    try {
      final response = await _apiClient.post(UApiUrls.logout);

      return ApiResponse.success(
        null,
        message: 'Logout successful',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'An unexpected error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Get user profile
  Future<ApiResponse<Map<String, dynamic>>> getUserProfile() async {
    try {
      final response = await _apiClient.get(UApiUrls.authProfile);

      return ApiResponse.success(
        response.data as Map<String, dynamic>,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'An unexpected error occurred');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Register device with the backend
  Future<ApiResponse<int>> registerDevice() async {
    try {
      // Get device information
      final deviceInfo = await _deviceInfoService.getDeviceInfo();

      // Create form data
      final formData = FormData.fromMap(deviceInfo);

      // Make API call
      final response = await _apiClient.post(
        UApiUrls.deviceRegister,
        data: formData,
      );

      // Extract device_id from response
      final deviceId = response.data['data']['device_id'] as int;

      return ApiResponse.success(
        deviceId,
        message: response.data['message'] ?? 'Device registered successfully',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'Failed to register device');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Activate user account with verification code
  Future<ApiResponse<void>> activateAccount({
    required String email,
    required String token,
  }) async {
    try {
      final formData = FormData.fromMap({'token': token, 'email': email});

      final response = await _apiClient.post(
        UApiUrls.accountActivate,
        data: formData,
      );

      return ApiResponse.success(
        null,
        message: response.data['message'] ?? 'Account verified successfully',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'Verification failed');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }
}
