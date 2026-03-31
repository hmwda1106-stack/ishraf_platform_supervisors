/// Custom Exceptions for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  
  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });
  
  @override
  String toString() {
    if (code != null) {
      return '$runtimeType: [$code] $message';
    }
    return '$runtimeType: $message';
  }
}

/// Authentication Exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'غير مصرح لك بالوصول',
    super.code = 'UNAUTHORIZED',
    super.originalError,
  });
}

class SessionExpiredException extends AppException {
  const SessionExpiredException({
    super.message = 'انتهت صلاحية الجلسة',
    super.code = 'SESSION_EXPIRED',
    super.originalError,
  });
}

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException({
    super.message = 'بيانات الدخول غير صحيحة',
    super.code = 'INVALID_CREDENTIALS',
    super.originalError,
  });
}

/// Network Exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

class NoInternetException extends AppException {
  const NoInternetException({
    super.message = 'لا يوجد اتصال بالإنترنت',
    super.code = 'NO_INTERNET',
    super.originalError,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'انتهت مهلة الاتصال',
    super.code = 'TIMEOUT',
    super.originalError,
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'خطأ في الخادم',
    super.code = 'SERVER_ERROR',
    super.originalError,
  });
}

/// Data Exceptions
class DataException extends AppException {
  const DataException({
    required super.message,
    super.code,
    super.originalError,
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'العنصر غير موجود',
    super.code = 'NOT_FOUND',
    super.originalError,
  });
}

class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.originalError,
  });
}

/// Cache Exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
  });
}
