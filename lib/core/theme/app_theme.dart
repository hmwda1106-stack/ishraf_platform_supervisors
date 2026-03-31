import 'package:flutter/material.dart';
import 'color_tokens.dart';
import 'typography.dart';
import 'spacing.dart';

/// Light Theme Configuration
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  
  // Color Scheme
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.accent,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.accentLight,
    onTertiaryContainer: AppColors.accentDark,
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.error,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    outline: AppColors.dividerLight,
    shadow: AppColors.shadowLight,
  ),
  
  // Scaffold
  scaffoldBackgroundColor: AppColors.backgroundLight,
  
  // AppBar Theme
  appBarTheme: const AppBarTheme(
    elevation: AppSpacing.elevation0,
    centerTitle: true,
    backgroundColor: AppColors.surfaceLight,
    foregroundColor: AppColors.textPrimaryLight,
    iconTheme: IconThemeData(
      color: AppColors.textPrimaryLight,
      size: AppSpacing.iconLg,
    ),
    titleTextStyle: AppTypography.titleLarge,
  ),
  
  // Card Theme
  cardTheme: CardTheme(
    elevation: AppSpacing.elevation2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    ),
    color: AppColors.cardLight,
    margin: const EdgeInsets.all(AppSpacing.cardMargin),
  ),
  
  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: AppSpacing.elevation1,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mdl,
        vertical: AppSpacing.smd,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      textStyle: AppTypography.button,
    ),
  ),
  
  // Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      textStyle: AppTypography.button,
    ),
  ),
  
  // Outlined Button Theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mdl,
        vertical: AppSpacing.smd,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      side: const BorderSide(color: AppColors.primary, width: 1),
      textStyle: AppTypography.button,
    ),
  ),
  
  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLight,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.gray300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.gray300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHintLight),
    labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
    errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
  ),
  
  // Text Theme
  textTheme: lightTextTheme,
  
  // Icon Theme
  iconTheme: const IconThemeData(
    color: AppColors.textPrimaryLight,
    size: AppSpacing.iconMd,
  ),
  
  // Divider Theme
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: AppSpacing.md,
  ),
  
  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    elevation: AppSpacing.elevation4,
  ),
  
  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.gray100,
    deleteIconColor: AppColors.textSecondaryLight,
    labelStyle: AppTypography.bodySmall,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
    ),
  ),
  
  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondaryLight,
    type: BottomNavigationBarType.fixed,
    elevation: AppSpacing.elevation8,
  ),
  
  // Navigation Bar Theme (Material 3)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.surfaceLight,
    indicatorColor: AppColors.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTypography.labelMedium.copyWith(color: AppColors.primary);
      }
      return AppTypography.labelMedium.copyWith(color: AppColors.textSecondaryLight);
    }),
  ),
  
  // Dialog Theme
  dialogTheme: DialogTheme(
    elevation: AppSpacing.elevation8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
    ),
    titleTextStyle: AppTypography.headlineSmall,
    contentTextStyle: AppTypography.bodyMedium,
  ),
  
  // Snackbar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.gray800,
    contentTextStyle: AppTypography.bodyMedium.copyWith(color: AppColors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
    ),
    behavior: SnackBarBehavior.floating,
  ),
  
  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.gray200,
  ),
  
  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.gray400;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return AppColors.gray300;
    }),
  ),
  
  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.white),
  ),
  
  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.gray400;
    }),
  ),
);
