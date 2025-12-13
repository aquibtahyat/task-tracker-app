import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppAppBarTheme {
  AppAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.white, size: 24),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: 24),
    titleTextStyle: AppTextTheme.lightTextTheme.headlineSmall?.copyWith(
      color: AppColors.white,
    ),
  );
}
