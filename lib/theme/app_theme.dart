import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

//light mode 
class AppTheme {
  static final light = ThemeData(
    textTheme: AppTypography.textTheme.apply(
      bodyColor: AppColors.lightOnSecondary,
      displayColor: AppColors.lightOnSecondary,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackgroundDefault,

    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      surface: AppColors.lightBackgroundCard,
      onSurface: AppColors.lightOnSecondary,
      outline: AppColors.lightBorderActive,
      
    )
  );
}