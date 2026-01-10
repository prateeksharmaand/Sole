import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'api_exceptions.dart';

/// Auth Interceptor - Adds authentication token to requests
class AuthInterceptor extends Interceptor {
  final GetStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get token from storage
    final token = _storage.read('auth_token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}

/// API Key Interceptor - Adds API key to headers
class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = dotenv.env['API_KEY'];

    if (apiKey != null) {
      options.headers['apiKey'] = apiKey;
    }

    super.onRequest(options, handler);
  }
}

/// Error Interceptor - Handles API errors and converts to custom exceptions
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: TimeoutException('Request timeout. Please try again.'),
          ),
        );
        break;

      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: NetworkException(
              'No internet connection. Please check your network.',
            ),
          ),
        );
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data?['message'] ?? 'An error occurred';

        if (statusCode == 401) {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: UnauthorizedException(message),
            ),
          );
        } else if (statusCode == 404) {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: NotFoundException(message),
            ),
          );
        } else if (statusCode != null && statusCode >= 500) {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: ServerException(message, statusCode),
            ),
          );
        } else {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: BadRequestException(message, statusCode),
            ),
          );
        }
        break;

      default:
        handler.reject(err);
    }
  }
}
