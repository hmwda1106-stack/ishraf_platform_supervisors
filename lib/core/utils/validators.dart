import '../constants/app_constants.dart';

/// Form Validators for input validation
class Validators {
  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    
    return null;
  }
  
  /// Validate password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'يجب أن تكون كلمة المرور ${AppConstants.minPasswordLength} أحرف على الأقل';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return 'كلمة المرور طويلة جداً';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';
    }
    
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
    }
    
    return null;
  }
  
  /// Validate confirm password matches
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    
    return null;
  }
  
  /// Validate required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName مطلوب';
    }
    
    return null;
  }
  
  /// Validate phone number (Gulf region format)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    
    // Remove spaces and dashes
    final cleanedValue = value.replaceAll(RegExp(r'[\s-]'), '');
    
    // Check if it starts with + or 00 followed by country code
    final phoneRegex = RegExp(r'^(\+|00)?[965971966968974967973970975][0-9]{7,9}$');
    
    if (!phoneRegex.hasMatch(cleanedValue)) {
      return 'صيغة رقم الهاتف غير صحيحة';
    }
    
    return null;
  }
  
  /// Validate numeric input
  static String? validateNumber(String? value, {double? min, double? max}) {
    if (value == null || value.isEmpty) {
      return 'الرقم مطلوب';
    }
    
    final numValue = double.tryParse(value);
    
    if (numValue == null) {
      return 'الرجاء إدخال رقم صحيح';
    }
    
    if (min != null && numValue < min) {
      return 'يجب أن يكون الرقم $min على الأقل';
    }
    
    if (max != null && numValue > max) {
      return 'يجب ألا يتجاوز الرقم $max';
    }
    
    return null;
  }
  
  /// Validate length
  static String? validateLength(String? value, {int? minLength, int? maxLength}) {
    if (value == null) {
      return null;
    }
    
    if (minLength != null && value.length < minLength) {
      return 'يجب أن يكون النص $minLength أحرف على الأقل';
    }
    
    if (maxLength != null && value.length > maxLength) {
      return 'يجب ألا يتجاوز النص $maxLength حرف';
    }
    
    return null;
  }
}
