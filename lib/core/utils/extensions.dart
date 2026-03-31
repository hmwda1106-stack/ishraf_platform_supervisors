import 'package:flutter/material.dart';

/// Extension methods for common operations
extension ContextExtensions on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;
  
  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  
  /// Check if device is tablet
  bool get isTablet => screenWidth >= 600;
  
  /// Check if device is mobile
  bool get isMobile => screenWidth < 600;
  
  /// Get theme data
  ThemeData get theme => Theme.of(this);
  
  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  /// Get brightness
  Brightness get brightness => Theme.of(this).brightness;
  
  /// Check if dark mode
  bool get isDarkMode => brightness == Brightness.dark;
  
  /// Show snackbar
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
  
  /// Show error snackbar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }
  
  /// Navigate to screen
  Future<T?> navigateTo<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
  
  /// Navigate and replace
  Future<T?> navigateAndReplace<T>(Widget screen) {
    return Navigator.pushReplacement<T, dynamic>(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
  
  /// Pop current screen
  void pop<T>([T? result]) {
    Navigator.pop<T>(this, result);
  }
}

extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  /// Check if string is email
  bool get isEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  }
  
  /// Check if string is phone number
  bool get isPhoneNumber {
    return RegExp(r'^(\+|00)?[965971966968974967973970975][0-9]{7,9}$').hasMatch(this);
  }
  
  /// Remove all spaces
  String removeSpaces() {
    return replaceAll(' ', '');
  }
  
  /// Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

extension ListExtensions<T> on List<T> {
  /// Check if list is not empty
  bool get isNotEmpty => !isEmpty;
  
  /// Get first element or null
  T? get firstOrNull => isEmpty ? null : first;
  
  /// Get last element or null
  T? get lastOrNull => isEmpty ? null : last;
}

extension DateTimeExtensions on DateTime {
  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());
  
  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());
  
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);
  
  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}

extension IntExtensions on int {
  /// Convert to Duration in days
  Duration get days => Duration(days: this);
  
  /// Convert to Duration in hours
  Duration get hours => Duration(hours: this);
  
  /// Convert to Duration in minutes
  Duration get minutes => Duration(minutes: this);
  
  /// Convert to Duration in seconds
  Duration get seconds => Duration(seconds: this);
}
