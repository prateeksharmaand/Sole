import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_exceptions.dart';
import '../models/dashboard_model.dart';
import '../../utils/constants/apis.dart';

/// Dashboard Repository
class DashboardRepository {
  final ApiClient _apiClient = ApiClient();

  /// Get dashboard data
  Future<ApiResponse<DashboardData>> getDashboardData() async {
    try {
      final response = await _apiClient.post(UApiUrls.dashboard);

      // Parse response
      final dashboardResponse = DashboardResponse.fromJson(response.data);

      if (dashboardResponse.success && dashboardResponse.data != null) {
        return ApiResponse.success(
          dashboardResponse.data!,
          message: dashboardResponse.message,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          dashboardResponse.message,
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
      return ApiResponse.error(e.message ?? 'Failed to fetch dashboard data');
    } catch (e) {
      return ApiResponse.error('An unexpected error occurred: $e');
    }
  }
}
