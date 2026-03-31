import 'package:flutter/material.dart';

/// Spacing tokens for consistent spacing throughout the app
/// Based on 4px grid system
class AppSpacing {
  // Base unit
  static const double base = 4.0;
  
  // Extra Small
  static const double xxs = 2.0;    // 0.5x
  static const double xs = 4.0;     // 1x
  
  // Small
  static const double sm = 8.0;     // 2x
  static const double smd = 12.0;   // 3x
  
  // Medium
  static const double md = 16.0;    // 4x
  static const double mdk = 20.0;   // 5x
  static const double mdl = 24.0;   // 6x
  
  // Large
  static const double lg = 32.0;    // 8x
  static const double xl = 40.0;    // 10x
  static const double xxl = 48.0;   // 12x
  static const double xxxl = 64.0;  // 16x
  
  // Common spacings
  static const double cardPadding = 16.0;
  static const double cardMargin = 8.0;
  static const double sectionSpacing = 24.0;
  static const double pagePadding = 16.0;
  
  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  
  // Avatar sizes
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;
  static const double avatarXl = 80.0;
  
  // Border radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusFull = 9999.0;
  
  // Elevation
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation3 = 3.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;
}

/// Extension for convenient spacing access
extension SpacingExtension on num {
  /// Returns value as EdgeInsets.all
  EdgeInsets get all => EdgeInsets.all(toDouble());
  
  /// Returns value as EdgeInsets.symmetric
  EdgeInsets get symmetric => EdgeInsets.symmetric(
    horizontal: toDouble(),
    vertical: toDouble(),
  );
  
  /// Returns value as EdgeInsets.only left/right based on RTL
  EdgeInsets get start => EdgeInsets.only(left: toDouble());
  
  /// Returns value as EdgeInsets.only right
  EdgeInsets get end => EdgeInsets.only(right: toDouble());
  
  /// Returns value as EdgeInsets.only top
  EdgeInsets get top => EdgeInsets.only(top: toDouble());
  
  /// Returns value as EdgeInsets.only bottom
  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble());
  
  /// Returns value as EdgeInsets.horizontal
  EdgeInsets get horizontal => EdgeInsets.horizontal(horizontal: toDouble());
  
  /// Returns value as EdgeInsets.vertical
  EdgeInsets get vertical => EdgeInsets.vertical(vertical: toDouble());
}
