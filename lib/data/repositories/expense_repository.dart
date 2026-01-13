import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/expense_model.dart';
import '../../utils/popups/snackbar_helpers.dart';
import '../../utils/constants/apis.dart';

/// Expense Repository
class ExpenseRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get expenses with pagination, filtering, and sorting
  ///
  /// [page] - Page number (default: 1)
  /// [pageSize] - Number of items per page (default: 10)
  /// [filterName] - Optional filter by name
  /// [sortBy] - Sort field (default: date_of_purchase)
  /// [sortOrder] - Sort order: 'asc' or 'desc' (default: desc)
  ///
  /// Returns [ApiResponse<ExpenseData>] containing expense details and pagination info
  Future<ApiResponse<ExpenseData>> getExpenses({
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
        UApiUrls.expenses,
        queryParameters: queryParams,
      );

      // Parse response
      final expenseResponse = ExpenseResponse.fromJson(response.data);

      if (expenseResponse.success && expenseResponse.data != null) {
        return ApiResponse.success(
          expenseResponse.data!,
          message: expenseResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: expenseResponse.message,
        );

        return ApiResponse.error(
          expenseResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch expenses';

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

  /// Get expense by ID
  ///
  /// [expenseId] - The ID of the expense to fetch
  ///
  /// Returns [ApiResponse<ExpenseModel>] containing the expense details
  Future<ApiResponse<ExpenseModel>> getExpenseById(int expenseId) async {
    try {
      final response = await _apiClient.get('${UApiUrls.expense}/$expenseId');

      // Parse response
      final expenseResponse = SimpleExpenseResponse.fromJson(response.data);

      if (expenseResponse.success && expenseResponse.data != null) {
        // Convert Map to ExpenseModel
        final expenseModel = ExpenseModel.fromJson(expenseResponse.data!);

        return ApiResponse.success(
          expenseModel,
          message: expenseResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        // Show error snackbar when success is false
        USnackBarHelpers.errorSnackBar(
          title: 'Error',
          message: expenseResponse.message,
        );

        return ApiResponse.error(
          expenseResponse.message,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to fetch expense details';

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

  /// Create a new expense
  ///
  /// [clientId] - Client ID (required)
  /// [name] - Expense name (required)
  /// [description] - Expense description (required)
  /// [date] - Expense date in yyyy-MM-dd format (required)
  /// [price] - Expense price (required)
  /// [gst] - GST flag: 0 or 1 (default: 0)
  /// [isAsset] - Is asset: "yes" or "no" (default: "no")
  /// [classificationIds] - List of existing classification IDs (optional)
  /// [classificationNames] - List of new classification names (optional)
  /// [paidWithCash] - Payment method: 0 or 1 (default: 0)
  /// [imagePath] - Receipt image file path (optional)
  Future<ApiResponse<void>> createExpense({
    required int clientId,
    required String name,
    required String description,
    required String date,
    required num price,
    int gst = 0,
    String isAsset = 'no',
    List<int>? classificationIds,
    List<String>? classificationNames,
    int paidWithCash = 0,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'client_id': clientId,
        'name': name,
        'description': description,
        'date': date,
        'price': price,
        'gst': gst,
        'is_asset': isAsset,
        'paid_with_cash': paidWithCash,
      });

      // Add classification IDs
      if (classificationIds != null && classificationIds.isNotEmpty) {
        for (int i = 0; i < classificationIds.length; i++) {
          formData.fields.add(
            MapEntry(
              'classifications[id][$i]',
              classificationIds[i].toString(),
            ),
          );
        }
      }

      // Add classification names
      if (classificationNames != null && classificationNames.isNotEmpty) {
        for (int i = 0; i < classificationNames.length; i++) {
          formData.fields.add(
            MapEntry('classifications[name][$i]', classificationNames[i]),
          );
        }
      }

      // Add image if provided
      if (imagePath != null && imagePath.isNotEmpty) {
        formData.files.add(
          MapEntry('image', await MultipartFile.fromFile(imagePath)),
        );
      }

      final response = await _apiClient.post(UApiUrls.expense, data: formData);

      final simpleResponse = SimpleExpenseResponse.fromJson(response.data);

      if (simpleResponse.success || simpleResponse.message == "Init error") {
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
      String errorMessage = 'Failed to create expense';

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

  /// Edit an existing expense
  ///
  /// [expenseId] - Expense ID (required)
  /// [accountSubcategoryId] - Account subcategory ID (optional)
  /// Other parameters same as createExpense
  Future<ApiResponse<void>> editExpense({
    required int expenseId,
    required int clientId,
    int? accountSubcategoryId,
    required String name,
    required String description,
    required String date,
    required num price,
    int gst = 0,
    String isAsset = 'no',
    List<int>? classificationIds,
    List<String>? classificationNames,
    int paidWithCash = 0,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': expenseId, // Changed from 'expense_id' to 'id'
        'client_id': clientId,
        'name': name,
        'description': description,
        'date': date,
        'price': price,
        'gst': gst,
        'is_asset': isAsset,
        'paid_with_cash': paidWithCash,
      });

      // Add account_subcategory_id if provided
      if (accountSubcategoryId != null) {
        formData.fields.add(
          MapEntry('account_subcategory_id', accountSubcategoryId.toString()),
        );
      }

      // Add classification IDs
      if (classificationIds != null && classificationIds.isNotEmpty) {
        for (int i = 0; i < classificationIds.length; i++) {
          formData.fields.add(
            MapEntry(
              'classifications[id][$i]',
              classificationIds[i].toString(),
            ),
          );
        }
      }

      // Add classification names
      if (classificationNames != null && classificationNames.isNotEmpty) {
        for (int i = 0; i < classificationNames.length; i++) {
          formData.fields.add(
            MapEntry('classifications[name][$i]', classificationNames[i]),
          );
        }
      }

      // Add image if provided
      if (imagePath != null && imagePath.isNotEmpty) {
        formData.files.add(
          MapEntry('image', await MultipartFile.fromFile(imagePath)),
        );
      }

      final response = await _apiClient.post(
        UApiUrls.expenseEdit,
        data: formData,
      );

      final simpleResponse = SimpleExpenseResponse.fromJson(response.data);

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
      String errorMessage = 'Failed to update expense';

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
