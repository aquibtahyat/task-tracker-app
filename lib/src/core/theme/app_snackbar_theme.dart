import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppSnackBarTheme {
  AppSnackBarTheme._();

  static final SnackBarThemeData lightSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primaryLight,
    contentTextStyle: AppTextTheme.lightTextTheme.labelLarge,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
    elevation: 6,
    insetPadding: const EdgeInsets.all(16),
  );
}
