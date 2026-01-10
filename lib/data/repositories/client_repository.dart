import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/client_model.dart';
import 'package:dio/dio.dart';
import '../../utils/constants/apis.dart';

/// Client Repository
class ClientRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get all clients
  ///
  /// Parameters:
  /// - [pageSize]: Number of clients per page (default: 1000)
  /// - [type]: Filter by type ('client' or 'supplier')
  Future<ApiResponse<List<ClientDetails>>> getClients({
    int pageSize = 1000,
    String type = 'client',
  }) async {
    try {
      final response = await _apiClient.get(
        UApiUrls.clients,
        queryParameters: {'page_size': pageSize, 'filter_by[type]': type},
      );

      // Parse response
      final clientResponse = ClientResponse.fromJson(response.data);

      if (clientResponse.success && clientResponse.data != null) {
        return ApiResponse.success(
          clientResponse.data!.clientsDetails,
          message: clientResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          clientResponse.message,
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
      return ApiResponse.error(e.message ?? 'Failed to fetch clients');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }
}
