/// Application Constants
class AppConstants {
  // App Information
  static const String appName = 'تطبيق المشرف';
  static const String appNameEn = 'Supervisor App';
  static const String appVersion = '1.0.0';
  static const int appBuildNumber = 1;
  
  // Supported Languages
  static const List<String> supportedLanguages = ['ar', 'en'];
  static const String defaultLanguage = 'ar';
  
  // Theme Settings
  static const String defaultThemeMode = 'system'; // system, light, dark
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Duration
  static const int cacheDurationMinutes = 30;
  
  // Session Settings
  static const int sessionTimeoutMinutes = 60;
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'dd/MM/yyyy';
  static const String displayDateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  
  // Image Settings
  static const int maxImageSizeMB = 5;
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
}
