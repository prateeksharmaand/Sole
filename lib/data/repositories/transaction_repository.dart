import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/bank_transaction_model.dart';
import '../models/transaction_model.dart';
import '../models/bulk_transaction_model.dart';
import '../models/add_transaction_model.dart';
import '../../utils/constants/apis.dart';

/// Transaction Repository
class TransactionRepository {
  final ApiClient _apiClient = ApiClient();

  /// Add a new transaction
  ///
  /// Parameters:
  /// - [transactionType]: Transaction type (1 by default)
  /// - [amount]: Transaction amount
  /// - [transactionDate]: Transaction date (YYYY-MM-DD)
  /// - [description]: Transaction description
  /// - [clientId]: Optional client ID
  /// - [expenseId]: Optional expense ID
  /// - [assetId]: Optional asset ID
  /// - [invoiceId]: Optional invoice ID
  Future<ApiResponse<Transaction>> addTransaction({
    required int transactionType,
    required double amount,
    required String transactionDate,
    required String description,
    int? clientId,
    int? expenseId,
    int? assetId,
    int? invoiceId,
  }) async {
    try {
      // Build form data - API requires all fields even if empty
      final formData = FormData.fromMap({
        'transaction_type': transactionType.toString(),
        'amount': amount.toString(),
        'transaction_date': transactionDate,
        'description': description,
        'client_id': clientId?.toString() ?? '',
        'expense_id': expenseId?.toString() ?? '',
        'asset_id': assetId?.toString() ?? '',
        'invoice_id': invoiceId?.toString() ?? '',
      });

      final response = await _apiClient.post(
        UApiUrls.addTransaction,
        data: formData,
      );

      // Parse response
      final addResponse = AddTransactionResponse.fromJson(response.data);

      if (addResponse.success && addResponse.data != null) {
        return ApiResponse.success(
          addResponse.data!.transaction,
          message: addResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          addResponse.message,
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
      return ApiResponse.error(e.message ?? 'Failed to add transaction');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Get bank transactions with pagination and filters
  ///
  /// Parameters:
  /// - [pageSize]: Number of transactions per page (default: 10)
  /// - [page]: Page number (default: 1)
  /// - [filterByType]: Filter by type ('debit' or 'credit')
  Future<ApiResponse<BankTransactionData>> getBankTransactions({
    int pageSize = 10,
    int page = 1,
    String? filterByType,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{
        'page_size': pageSize,
        'page': page,
      };

      // Add filter if provided
      if (filterByType != null) {
        queryParams['filter_by[type]'] = filterByType;
      }

      final response = await _apiClient.get(
        UApiUrls.bankTransactions,
        queryParameters: queryParams,
      );

      // Parse response
      final transactionResponse = BankTransactionResponse.fromJson(
        response.data,
      );

      if (transactionResponse.success && transactionResponse.data != null) {
        return ApiResponse.success(
          transactionResponse.data!,
          message: transactionResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          transactionResponse.message,
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
      return ApiResponse.error(e.message ?? 'Failed to fetch transactions');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Get sole saved transactions with advanced filtering
  ///
  /// Parameters:
  /// - [pageSize]: Number of transactions per page (default: 100)
  /// - [page]: Page number (default: 1)
  /// - [filterByCash]: Filter by cash transactions (1 for yes, 0 for no)
  /// - [startDate]: Start date for filtering (YYYY-MM-DD)
  /// - [endDate]: End date for filtering (YYYY-MM-DD)
  /// - [minPrice]: Minimum price filter
  /// - [maxPrice]: Maximum price filter
  /// - [personal]: Filter personal transactions (1 for yes)
  /// - [transfer]: Filter transfer transactions (1 for yes)
  /// - [accountSubcategoryIds]: List of account subcategory IDs to filter
  Future<ApiResponse<SoleTransactionResponse>> getSoleSavedTransactions({
    int pageSize = 100,
    int page = 1,
    int? filterByCash,
    String? startDate,
    String? endDate,
    double? minPrice,
    double? maxPrice,
    int? personal,
    int? transfer,
    List<int>? accountSubcategoryIds,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{
        'page_size': pageSize,
        'page': page,
      };

      // Add filters if provided
      if (filterByCash != null) {
        queryParams['filter_by[cash]'] = filterByCash;
      }
      if (startDate != null) {
        queryParams['filter_by[start_date]'] = startDate;
      }
      if (endDate != null) {
        queryParams['filter_by[end_date]'] = endDate;
      }
      if (minPrice != null) {
        queryParams['filter_by[min_price]'] = minPrice;
      }
      if (maxPrice != null) {
        queryParams['filter_by[max_price]'] = maxPrice;
      }
      if (personal != null) {
        queryParams['filter_by[personal]'] = personal;
      }
      if (transfer != null) {
        queryParams['filter_by[transfer]'] = transfer;
      }
      if (accountSubcategoryIds != null && accountSubcategoryIds.isNotEmpty) {
        for (var id in accountSubcategoryIds) {
          queryParams['filter_by[account_subcategory_id]'] = id;
        }
      }

      final response = await _apiClient.get(
        UApiUrls.soleSavedTransactions,
        queryParameters: queryParams,
      );

      // Parse response
      final transactionResponse = SoleTransactionResponse.fromJson(
        response.data,
      );

      return ApiResponse.success(
        transactionResponse,
        message: 'Sole saved transactions loaded successfully',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (e.error is ApiException) {
        return ApiResponse.error(
          (e.error as ApiException).message,
          statusCode: (e.error as ApiException).statusCode,
        );
      }
      return ApiResponse.error(e.message ?? 'Failed to fetch transactions');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Upload bulk transactions from CSV file
  ///
  /// Parameters:
  /// - [filePath]: Path to the CSV file
  /// - [userId]: User ID
  Future<ApiResponse<BulkTransactionData>> uploadBulkTransactions({
    required String filePath,
    required int userId,
  }) async {
    try {
      // Create form data with file and user_id
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
        'user_id': userId.toString(),
      });

      final response = await _apiClient.post(
        UApiUrls.bulkTransactionsUpload,
        data: formData,
      );

      // Parse response
      final uploadResponse = BulkTransactionUploadResponse.fromJson(
        response.data,
      );

      if (uploadResponse.success && uploadResponse.data != null) {
        return ApiResponse.success(
          uploadResponse.data!,
          message: uploadResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          uploadResponse.message,
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
      return ApiResponse.error(e.message ?? 'Failed to upload transactions');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }

  /// Get all bank transactions (fetch all pages)
  Future<ApiResponse<List<BankTransactionDetail>>> getAllBankTransactions({
    int pageSize = 10,
    String? filterByType,
  }) async {
    try {
      List<BankTransactionDetail> allTransactions = [];
      int currentPage = 1;
      int totalPages = 1;

      // Fetch first page to get total pages
      final firstPageResponse = await getBankTransactions(
        pageSize: pageSize,
        page: currentPage,
        filterByType: filterByType,
      );

      if (!firstPageResponse.success || firstPageResponse.data == null) {
        return ApiResponse.error(
          firstPageResponse.message ?? 'Failed to fetch transactions',
        );
      }

      allTransactions.addAll(
        firstPageResponse.data!.bankTransactions.bankTransactionDetails,
      );
      totalPages = firstPageResponse.data!.bankTransactions.totalPages;

      // Fetch remaining pages
      while (currentPage < totalPages) {
        currentPage++;
        final pageResponse = await getBankTransactions(
          pageSize: pageSize,
          page: currentPage,
          filterByType: filterByType,
        );

        if (pageResponse.success && pageResponse.data != null) {
          allTransactions.addAll(
            pageResponse.data!.bankTransactions.bankTransactionDetails,
          );
        }
      }

      return ApiResponse.success(
        allTransactions,
        message: 'All transactions loaded successfully',
      );
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }
}
