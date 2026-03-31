/// API Constants for the Supervisor App
class ApiConstants {
  // Base URL for staging environment
  static const String baseUrl = 'https://ishraf-platform-backend-staging.onrender.com/api/v1';
  
  // Production base URL (to be configured)
  // static const String productionBaseUrl = 'https://ishraf-platform.com/api/v1';
  
  // API Endpoints - Authentication
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  // API Endpoints - Dashboard
  static const String dashboardStatsEndpoint = '/dashboard/stats';
  static const String assignedClassesEndpoint = '/dashboard/assigned-classes';
  static const String recentBehaviorsEndpoint = '/dashboard/recent-behaviors';
  static const String announcementsEndpoint = '/dashboard/announcements';
  
  // API Endpoints - Behavior Management
  static const String behaviorCategoriesEndpoint = '/behavior/categories';
  static const String behaviorRecordsEndpoint = '/behavior/records';
  static const String behaviorRecordDetailEndpoint = '/behavior/records/{id}';
  
  // API Endpoints - Attendance
  static const String attendanceSessionsEndpoint = '/attendance/sessions';
  static const String attendanceSessionDetailEndpoint = '/attendance/sessions/{id}';
  static const String attendanceRecordsEndpoint = '/attendance/records';
  
  // API Endpoints - Reporting
  static const String reportsEndpoint = '/reports';
  static const String behaviorReportsEndpoint = '/reports/behavior';
  static const String attendanceReportsEndpoint = '/reports/attendance';
  
  // API Endpoints - Communication
  static const String messagesEndpoint = '/messages';
  static const String notificationsEndpoint = '/notifications';
  
  // API Endpoints - Profile
  static const String profileEndpoint = '/profile';
  static const String updateProfileEndpoint = '/profile/update';
  static const String changePasswordEndpoint = '/profile/change-password';
  
  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Headers
  static const String contentTypeHeader = 'Content-Type';
  static const String jsonContentType = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
