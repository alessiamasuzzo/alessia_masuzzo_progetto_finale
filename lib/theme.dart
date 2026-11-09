import 'package:flutter/material.dart';

class AppColors{

  //Light mode

  //primary
  static const lightPrimary = Color(0xFF935FA7);
  static const lightPrimaryPressed = Color(0xff7E4C91);
  static const lightPrimaryDisabled = Color(0xffB594B6);

  //secondary
  static const lightSecondary = Color(0xff82FF9E);
  static const lightSecondaryPressed = Color(0xff5FE07F);
  static const lightSecondaryDisabled = Color(0xffA9FBC3);

  //background
  static const lightBackgroundCard = Color(0xffFFFFFF);
  static const lightBackgroundDefault = Color(0xffFAF7FB);

  //text 
  static const lightTextDefault  = Color(0xff2a1f2d);
  static const lightOnPrimary = Color(0xffffffff);
  static const lightOnSecondary = Color(0xff2a1f2d);

  //border
  static const lightBorderDefault = Color(0xffe3dce6);
  static const lightBorderActive = Color(0xff7a6b80);

}

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      
      
    )
  );
}