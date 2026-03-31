import 'package:intl/intl.dart';

/// Date Formatting Utilities
class DateFormatter {
  /// Format date to display format (dd/MM/yyyy)
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  
  /// Format date and time to display format (dd/MM/yyyy HH:mm)
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
  
  /// Format time (HH:mm)
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
  
  /// Format to API format (yyyy-MM-dd)
  static String formatToApiDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  
  /// Format to API datetime format (yyyy-MM-ddTHH:mm:ss)
  static String formatToApiDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
  }
  
  /// Parse from API date string
  static DateTime parseApiDate(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }
  
  /// Parse from API datetime string
  static DateTime parseApiDateTime(String dateTimeString) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTimeString);
  }
  
  /// Get relative time string (e.g., "منذ ساعتين", "اليوم", "أمس")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'الآن';
        }
        return 'منذ ${difference.inMinutes} دقيقة';
      }
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'منذ $weeks أسبوع';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months شهر';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'منذ $years سنة';
    }
  }
  
  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  /// Get day name in Arabic
  static String getDayNameArabic(DateTime date) {
    const days = [
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[date.weekday - 1];
  }
  
  /// Get month name in Arabic
  static String getMonthNameArabic(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[date.month - 1];
  }
  
  /// Format full date in Arabic
  static String formatFullDateArabic(DateTime date) {
    return '${getDayNameArabic(date)}، ${date.day} ${getMonthNameArabic(date)} ${date.year}';
  }
}
