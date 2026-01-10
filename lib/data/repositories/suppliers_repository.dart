import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/supplier_model.dart';
import '../../utils/popups/snackbar_helpers.dart';
import '../../utils/constants/apis.dart';

/// Suppliers Repository
class SuppliersRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get suppliers with pagination
  ///
  /// [page] - Page number (default: 1)
  /// [pageSize] - Number of items per page (default: 10)
  ///
  /// Returns [ApiResponse<SupplierData>] containing supplier details and pagination info
  Future<ApiResponse<SupplierData>> getSuppliers({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _apiClient.get(
        UApiUrls.suppliers,
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      // Parse response
      final supplierResponse = SupplierResponse.fromJson(response.data);

      if (supplierResponse.success && supplierResponse.data != null) {
        return ApiResponse.success(
          supplierResponse.data!,
          message: supplierResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: supplierResponse.message,
        );

        return ApiResponse.error(
          supplierResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch suppliers';

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
