import 'package:flutter/material.dart';
import 'color_tokens.dart';

/// Typography definitions for the application
/// Uses Cairo font family for Arabic/English support
class AppTypography {
  // Font Family
  static const String fontFamily = 'Cairo';
  
  // Display Styles (Large headings)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.25,
    letterSpacing: -0.25,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.45,
  );
  
  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.1,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0.15,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.25,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.4,
  );
  
  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.1,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  // Button Style
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0.1,
  );
  
  // Caption Style
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.4,
  );
  
  // Overline Style
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 1.5,
  );
}

/// Text Theme for Light Mode
TextTheme lightTextTheme = const TextTheme(
  displayLarge: AppTypography.displayLarge,
  displayMedium: AppTypography.displayMedium,
  displaySmall: AppTypography.displaySmall,
  headlineLarge: AppTypography.headlineLarge,
  headlineMedium: AppTypography.headlineMedium,
  headlineSmall: AppTypography.headlineSmall,
  titleLarge: AppTypography.titleLarge,
  titleMedium: AppTypography.titleMedium,
  titleSmall: AppTypography.titleSmall,
  bodyLarge: AppTypography.bodyLarge,
  bodyMedium: AppTypography.bodyMedium,
  bodySmall: AppTypography.bodySmall,
  labelLarge: AppTypography.labelLarge,
  labelMedium: AppTypography.labelMedium,
  labelSmall: AppTypography.labelSmall,
  button: AppTypography.button,
);

/// Text Theme for Dark Mode
TextTheme darkTextTheme = const TextTheme(
  displayLarge: AppTypography.displayLarge,
  displayMedium: AppTypography.displayMedium,
  displaySmall: AppTypography.displaySmall,
  headlineLarge: AppTypography.headlineLarge,
  headlineMedium: AppTypography.headlineMedium,
  headlineSmall: AppTypography.headlineSmall,
  titleLarge: AppTypography.titleLarge,
  titleMedium: AppTypography.titleMedium,
  titleSmall: AppTypography.titleSmall,
  bodyLarge: AppTypography.bodyLarge,
  bodyMedium: AppTypography.bodyMedium,
  bodySmall: AppTypography.bodySmall,
  labelLarge: AppTypography.labelLarge,
  labelMedium: AppTypography.labelMedium,
  labelSmall: AppTypography.labelSmall,
  button: AppTypography.button,
);
