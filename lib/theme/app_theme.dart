import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

//light mode 
class AppTheme {
  static final light = ThemeData(
navigationBarTheme: NavigationBarThemeData(
  backgroundColor: AppColors.lightNavBackground,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  height: 68,
  indicatorColor: AppColors.lightSecondary,
  indicatorShape: const StadiumBorder(),
  iconTheme: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return IconThemeData(color: AppColors.lightOnPrimary);
    }
    return IconThemeData(color: AppColors.lightBorderActive);
  }),
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return AppTypography.textTheme.labelSmall!.copyWith(
        color: AppColors.lightSecondary,
        fontWeight: FontWeight.w600,
      );
    }
    return AppTypography.textTheme.labelSmall!.copyWith(
      color: AppColors.lightOnSecondary,
    );
  }),
),
    cardTheme: CardThemeData(
      color: AppColors.lightBackgroundCard,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.lightBorderDefault),
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: AppColors.lightSecondary,
      showCheckmark: false,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
      labelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.textTheme.labelLarge!.copyWith(
            color: AppColors.lightOnPrimary,
          );
        }
        return AppTypography.textTheme.labelLarge!.copyWith(
          color: AppColors.lightOnSecondary,
        );
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
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