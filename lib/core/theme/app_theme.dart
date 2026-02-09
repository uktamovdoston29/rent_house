import 'package:flutter/material.dart';
import 'package:rent_house/core/color/app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.light(primary: AppColors.primary),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarThemeData(backgroundColor: AppColors.white),
  );
}
