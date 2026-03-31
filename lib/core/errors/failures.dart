import 'package:equatable/equatable.dart';

/// Base Failure class for error handling
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure({
    required this.message,
    this.code,
  });
  
  @override
  List<Object?> get props => [message, code];
  
  @override
  String toString() {
    if (code != null) {
      return '$runtimeType: [$code] $message';
    }
    return '$runtimeType: $message';
  }
}

/// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'غير مصرح لك بالوصول',
    super.code = 'UNAUTHORIZED',
  });
}

class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({
    super.message = 'انتهت صلاحية الجلسة',
    super.code = 'SESSION_EXPIRED',
  });
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'بيانات الدخول غير صحيحة',
    super.code = 'INVALID_CREDENTIALS',
  });
}

/// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = 'لا يوجد اتصال بالإنترنت',
    super.code = 'NO_INTERNET',
  });
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'انتهت مهلة الاتصال',
    super.code = 'TIMEOUT',
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'خطأ في الخادم',
    super.code = 'SERVER_ERROR',
  });
}

/// Data Failures
class DataFailure extends Failure {
  const DataFailure({
    required super.message,
    super.code,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'العنصر غير موجود',
    super.code = 'NOT_FOUND',
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'VALIDATION_ERROR',
  });
}

/// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// Unknown Failure (fallback)
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'حدث خطأ غير متوقع',
    super.code = 'UNKNOWN',
  });
}
