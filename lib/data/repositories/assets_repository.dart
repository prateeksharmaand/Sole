import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/asset_model.dart';
import '../../utils/popups/snackbar_helpers.dart';
import '../../utils/constants/apis.dart';

/// Assets Repository
class AssetsRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get assets with pagination, filtering, and sorting
  ///
  /// [page] - Page number (default: 1)
  /// [pageSize] - Number of items per page (default: 10)
  /// [filterName] - Optional filter by name
  /// [sortBy] - Sort field (default: date_of_purchase)
  /// [sortOrder] - Sort order: 'asc' or 'desc' (default: desc)
  ///
  /// Returns [ApiResponse<AssetData>] containing asset details and pagination info
  Future<ApiResponse<AssetData>> getAssets({
    int page = 1,
    int pageSize = 10,
    String? filterName,
    String sortBy = 'date_of_purchase',
    String sortOrder = 'desc',
  }) async {
    try {
      final queryParams = {
        'page': page,
        'page_size': pageSize,
        'filter_by[name]': filterName ?? '',
        'sort_by[$sortBy]': sortOrder,
      };

      final response = await _apiClient.get(
        UApiUrls.assets,
        queryParameters: queryParams,
      );

      // Parse response
      final assetResponse = AssetResponse.fromJson(response.data);

      if (assetResponse.success && assetResponse.data != null) {
        return ApiResponse.success(
          assetResponse.data!,
          message: assetResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: assetResponse.message,
        );

        return ApiResponse.error(
          assetResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch assets';

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

  /// Create a new asset
  ///
  /// [accountSubcategoryId] - Account subcategory ID (required)
  /// [name] - Asset name (required)
  /// [dateOfPurchase] - Purchase date in yyyy-MM-dd format (required)
  /// [price] - Asset price (required)
  /// [paidWithCash] - 0 or 1 (default: 0)
  /// [clientId] - Client ID (required)
  /// [gst] - GST flag: 0 or 1 (default: 0)
  /// [assetNo] - Asset number (optional)
  /// [assetImage] - Asset image file path (optional)
  Future<ApiResponse<void>> createAsset({
    required int accountSubcategoryId,
    required String name,
    required String dateOfPurchase,
    required num price,
    required int clientId,
    int paidWithCash = 0,
    int gst = 0,
    String? assetNo,
    String? assetImagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'account_subcategory_id': accountSubcategoryId,
        'name': name,
        'date_of_purchase': dateOfPurchase,
        'price': price,
        'paid_with_cash': paidWithCash,
        'client_id': clientId,
        'gst': gst,
        'asset_no': assetNo ?? '',
      });

      // Add image if provided
      if (assetImagePath != null && assetImagePath.isNotEmpty) {
        formData.files.add(
          MapEntry('asset_image', await MultipartFile.fromFile(assetImagePath)),
        );
      }

      final response = await _apiClient.post(UApiUrls.asset, data: formData);

      final simpleResponse = SimpleAssetResponse.fromJson(response.data);

      if (simpleResponse.success) {
        USnackBarHelpers.successSnackBar(
          title: 'Success',
          message: simpleResponse.message,
        );

        return ApiResponse.success(
          null,
          message: simpleResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: simpleResponse.message,
        );

        return ApiResponse.error(
          simpleResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to create asset';

      if (e.error is ApiException) {
        errorMessage = (e.error as ApiException).message;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(
        errorMessage,
        statusCode: (e.error is ApiException)
            ? (e.error as ApiException).statusCode
            : null,
      );
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: $e';

      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(errorMessage);
    }
  }

  /// Edit an existing asset
  ///
  /// [assetId] - Asset ID (required)
  /// Other parameters same as createAsset
  Future<ApiResponse<int>> editAsset({
    required int assetId,
    required int accountSubcategoryId,
    required String name,
    required String dateOfPurchase,
    required num price,
    required int clientId,
    int paidWithCash = 0,
    int gst = 0,
    String? assetNo,
    String? assetImagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'asset_id': assetId,
        'account_subcategory_id': accountSubcategoryId,
        'name': name,
        'date_of_purchase': dateOfPurchase,
        'price': price,
        'paid_with_cash': paidWithCash,
        'client_id': clientId,
        'gst': gst,
        'asset_no': assetNo ?? '',
      });

      // Add image if provided
      if (assetImagePath != null && assetImagePath.isNotEmpty) {
        formData.files.add(
          MapEntry('asset_image', await MultipartFile.fromFile(assetImagePath)),
        );
      }

      final response = await _apiClient.post(
        UApiUrls.assetEdit,
        data: formData,
      );

      final simpleResponse = SimpleAssetResponse.fromJson(response.data);

      if (simpleResponse.success) {
        USnackBarHelpers.successSnackBar(
          title: 'Success',
          message: simpleResponse.message,
        );

        // Extract asset_id from response
        final updatedAssetId = simpleResponse.data?['asset_id'] as int?;

        return ApiResponse.success(
          updatedAssetId ?? assetId,
          message: simpleResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: simpleResponse.message,
        );

        return ApiResponse.error(
          simpleResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to update asset';

      if (e.error is ApiException) {
        errorMessage = (e.error as ApiException).message;
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(
        errorMessage,
        statusCode: (e.error is ApiException)
            ? (e.error as ApiException).statusCode
            : null,
      );
    } catch (e) {
      final errorMessage = 'An unexpected error occurred: $e';

      USnackBarHelpers.errorSnackBar(title: 'Error', message: errorMessage);

      return ApiResponse.error(errorMessage);
    }
  }
}
