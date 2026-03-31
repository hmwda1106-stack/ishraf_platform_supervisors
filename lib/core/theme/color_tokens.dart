import 'package:flutter/material.dart';

/// Color Tokens for the application
/// Defines the complete color palette
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryContainer = Color(0xFFE3F2FD);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryLight = Color(0xFF64DBCB);
  static const Color secondaryDark = Color(0xFF007A6B);
  static const Color secondaryContainer = Color(0xFFE0F7FA);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF5722);
  static const Color accentLight = Color(0xFFFF8A65);
  static const Color accentDark = Color(0xFFE64A19);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFC8E6C9);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFECB3);
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFFFCDD2);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFBBDEFB);
  
  // Behavior Severity Colors
  static const Color severityLow = Color(0xFF4CAF50);
  static const Color severityMedium = Color(0xFFFF9800);
  static const Color severityHigh = Color(0xFFF44336);
  static const Color severityCritical = Color(0xFF9C27B0);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;
  
  // Gray Scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textDisabledLight = Color(0xFFBDBDBD);
  static const Color textHintLight = Color(0xFF9E9E9E);
  
  // Divider Colors
  static const Color dividerLight = Color(0xFFE0E0E0);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
}

/// Dark Theme Colors
class AppDarkColors {
  // Background Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);
  
  // Text Colors
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textDisabledDark = Color(0xFF6E6E6E);
  static const Color textHintDark = Color(0xFF808080);
  
  // Divider Colors
  static const Color dividerDark = Color(0xFF424242);
  
  // Shadow Colors
  static const Color shadowDark = Color(0x3D000000);
}
