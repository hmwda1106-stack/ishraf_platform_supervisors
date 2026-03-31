import 'package:flutter/material.dart';
import 'color_tokens.dart';
import 'typography.dart';
import 'spacing.dart';

/// Dark Theme Configuration
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  
  // Color Scheme
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.primaryDark,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accentLight,
    onTertiary: AppColors.accentDark,
    tertiaryContainer: AppColors.accentDark,
    onTertiaryContainer: AppColors.accentLight,
    error: AppColors.errorLight,
    onError: AppColors.error,
    errorContainer: AppColors.error,
    onErrorContainer: AppColors.errorLight,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    outline: AppColors.dividerDark,
    shadow: AppColors.shadowDark,
  ),
  
  // Scaffold
  scaffoldBackgroundColor: AppColors.backgroundDark,
  
  // AppBar Theme
  appBarTheme: const AppBarTheme(
    elevation: AppSpacing.elevation0,
    centerTitle: true,
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.textPrimaryDark,
    iconTheme: IconThemeData(
      color: AppColors.textPrimaryDark,
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
    color: AppColors.cardDark,
    margin: const EdgeInsets.all(AppSpacing.cardMargin),
  ),
  
  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: AppSpacing.elevation1,
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.primaryDark,
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
      foregroundColor: AppColors.primaryLight,
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
      foregroundColor: AppColors.primaryLight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.mdl,
        vertical: AppSpacing.smd,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      side: const BorderSide(color: AppColors.primaryLight, width: 1),
      textStyle: AppTypography.button,
    ),
  ),
  
  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceDark,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.gray700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.gray700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.errorLight),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
    ),
    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textHintDark),
    labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondaryDark),
    errorStyle: AppTypography.caption.copyWith(color: AppColors.errorLight),
  ),
  
  // Text Theme
  textTheme: darkTextTheme,
  
  // Icon Theme
  iconTheme: const IconThemeData(
    color: AppColors.textPrimaryDark,
    size: AppSpacing.iconMd,
  ),
  
  // Divider Theme
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: AppSpacing.md,
  ),
  
  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryLight,
    foregroundColor: AppColors.primaryDark,
    elevation: AppSpacing.elevation4,
  ),
  
  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.gray800,
    deleteIconColor: AppColors.textSecondaryDark,
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
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.textSecondaryDark,
    type: BottomNavigationBarType.fixed,
    elevation: AppSpacing.elevation8,
  ),
  
  // Navigation Bar Theme (Material 3)
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    indicatorColor: AppColors.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppTypography.labelMedium.copyWith(color: AppColors.primaryLight);
      }
      return AppTypography.labelMedium.copyWith(color: AppColors.textSecondaryDark);
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
    backgroundColor: AppColors.gray200,
    contentTextStyle: AppTypography.bodyMedium.copyWith(color: AppColors.gray900),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
    ),
    behavior: SnackBarBehavior.floating,
  ),
  
  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryLight,
    linearTrackColor: AppColors.gray700,
  ),
  
  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return AppColors.gray600;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryDark;
      }
      return AppColors.gray700;
    }),
  ),
  
  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(AppColors.primaryDark),
  ),
  
  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primaryLight;
      }
      return AppColors.gray600;
    }),
  ),
);
