class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class NetworkException extends ApiException {
  NetworkException([String message = 'No internet connection'])
    : super(message);
}

class ServerException extends ApiException {
  ServerException([String message = 'Server error occurred', int? statusCode])
    : super(message, statusCode);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Unauthorized access'])
    : super(message, 401);
}

class BadRequestException extends ApiException {
  BadRequestException([String message = 'Bad request', int? statusCode])
    : super(message, statusCode ?? 400);
}

class TimeoutException extends ApiException {
  TimeoutException([String message = 'Request timeout']) : super(message);
}

class NotFoundException extends ApiException {
  NotFoundException([String message = 'Resource not found'])
    : super(message, 404);
}
