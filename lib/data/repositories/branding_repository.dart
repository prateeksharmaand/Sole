import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/branding_model.dart';
import '../../utils/popups/snackbar_helpers.dart';
import '../../utils/constants/apis.dart';

/// Branding Repository
class BrandingRepository {
  final ApiClient _apiClient = ApiClient();

  /// Save branding settings
  ///
  /// [brandingModel] - The branding settings to save
  /// Returns [ApiResponse<void>] indicating success or failure
  Future<ApiResponse<void>> saveBranding(BrandingModel brandingModel) async {
    try {
      final response = await _apiClient.post(
        UApiUrls.saveBranding,
        data: brandingModel.toJson(),
      );

      // Parse response
      final brandingResponse = BrandingResponse.fromJson(response.data);

      if (brandingResponse.success) {
        // Show success snackbar
        USnackBarHelpers.successSnackBar(
          title: 'Success',
          message: brandingResponse.message,
        );

        return ApiResponse.success(
          null,
          message: brandingResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: brandingResponse.message,
        );

        return ApiResponse.error(
          brandingResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to save branding settings';

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

  /// Get branding settings
  ///
  /// Returns [ApiResponse<BrandingModel?>] containing branding settings or null if empty
  Future<ApiResponse<BrandingModel?>> getBranding() async {
    try {
      final response = await _apiClient.get(UApiUrls.getBranding);

      // Parse response
      final brandingResponse = BrandingResponse.fromJson(response.data);

      if (brandingResponse.success && brandingResponse.data.isNotEmpty) {
        final brandingModel = BrandingModel.fromJson(brandingResponse.data);

        return ApiResponse.success(
          brandingModel,
          message: brandingResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Return empty response if no data
        return ApiResponse.success(
          null,
          message: brandingResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch branding settings';

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
