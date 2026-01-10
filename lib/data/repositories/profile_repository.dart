import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/user_model.dart';
import '../../utils/popups/snackbar_helpers.dart';
import '../../utils/constants/apis.dart';

/// Profile Repository
class ProfileRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get user profile
  ///
  /// Returns [ApiResponse<UserModel>] containing user profile data
  Future<ApiResponse<UserModel>> getProfile() async {
    try {
      final response = await _apiClient.post(
        UApiUrls.getProfile,
        data: {}, // Empty body as per API spec
      );

      // Parse response
      final profileResponse = LoginResponse.fromJson(response.data);

      if (profileResponse.success && profileResponse.user != null) {
        return ApiResponse.success(
          profileResponse.user!,
          message: profileResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: profileResponse.message,
        );

        return ApiResponse.error(
          profileResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch profile';

      if (e.error is ApiException) {
        errorMessage = (e.error as ApiException).message;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      // Show error snackbar
      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(
        errorMessage,
        statusCode: (e.error is ApiException)
            ? (e.error as ApiException).statusCode
            : null,
      );
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: $e';

      // Show error snackbar
      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(errorMessage);
    }
  }
}
