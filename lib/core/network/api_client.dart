import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

/// API Client configuration and setup using Dio
class ApiClient {
  late final Dio _dio;
  
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.jsonContentType,
        },
      ),
    );
    
    // Add interceptors
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
  }
  
  Dio get dio => _dio;
  
  /// Set authentication token
  void setAuthToken(String token) {
    _dio.options.headers[ApiConstants.authorizationHeader] = 
        '${ApiConstants.bearerPrefix}$token';
  }
  
  /// Clear authentication token
  void clearAuthToken() {
    _dio.options.headers.remove(ApiConstants.authorizationHeader);
  }
  
  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters, options: options);
    } catch (e) {
      _handleError(e);
    }
  }
  
  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      _handleError(e);
    }
  }
  
  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      _handleError(e);
    }
  }
  
  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      _handleError(e);
    }
  }
  
  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(path, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      _handleError(e);
    }
  }
  
  /// Handle errors
  Never _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw const TimeoutException();
        case DioExceptionType.connectionError:
          throw const NoInternetException();
        case DioExceptionType.badResponse:
          if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
            throw const UnauthorizedException();
          } else if (error.response?.statusCode == 404) {
            throw const NotFoundException();
          } else {
            throw ServerException(
              message: error.response?.data['message'] ?? 'خطأ في الخادم',
              code: 'SERVER_${error.response?.statusCode}',
            );
          }
        case DioExceptionType.cancel:
          throw const AppException(message: 'تم إلغاء الطلب', code: 'CANCELLED');
        default:
          throw NetworkException(
            message: 'خطأ في الاتصال',
            originalError: error,
          );
      }
    } else if (error is AppException) {
      rethrow;
    } else {
      throw NetworkException(
        message: 'حدث خطأ غير متوقع',
        originalError: error,
      );
    }
  }
}

/// Logging Interceptor - Logs all requests and responses
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('📤 REQUEST[${options.method}] => PATH: ${options.path}');
    print('Headers: ${options.headers}');
    if (options.data != null) {
      print('Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('📥 RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('Data: ${response.data}');
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Message: ${err.message}');
    super.onError(err, handler);
  }
}

/// Auth Interceptor - Adds auth token to requests
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Token is already set in the client, but we can add additional logic here
    // For example, skip auth for login endpoint
    if (options.path.contains('/auth/login') || 
        options.path.contains('/auth/forgot-password') ||
        options.path.contains('/auth/reset-password')) {
      // Skip auth for public endpoints
    }
    super.onRequest(options, handler);
  }
}

/// Error Interceptor - Handles common error scenarios
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle session expiration
    if (err.response?.statusCode == 401) {
      // Could trigger logout or token refresh here
      print('⚠️ Session expired or unauthorized');
    }
    super.onError(err, handler);
  }
}
