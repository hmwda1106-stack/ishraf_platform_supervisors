/// Storage Keys for SharedPreferences and Secure Storage
class StorageKeys {
  // Authentication
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String isLoggedIn = 'is_logged_in';
  
  // User Data
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userRole = 'user_role';
  static const String userProfileData = 'user_profile_data';
  
  // Settings
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';
  
  // Cache
  static const String cachedDashboardData = 'cached_dashboard_data';
  static const String cachedBehaviorCategories = 'cached_behavior_categories';
  static const String lastCacheTime = 'last_cache_time';
  
  // Session
  static const String sessionStartTime = 'session_start_time';
  static const String lastActivityTime = 'last_activity_time';
}
