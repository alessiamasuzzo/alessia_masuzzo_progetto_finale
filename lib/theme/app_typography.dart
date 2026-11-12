import 'package:flutter/material.dart';

class AppTypography {
  static const TextTheme textTheme = TextTheme(
    // title (Fraunces)
    headlineLarge: TextStyle(
      fontFamily: 'Fraunces',
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Fraunces',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 32 / 24,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Fraunces',
      fontWeight: FontWeight.w400,
      fontSize: 20,
      height: 28 / 20,
    ),

    // body text (Manrope)
    bodyLarge: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
    ),

    // label (Manrope)
    labelLarge: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
    ),
  );
}