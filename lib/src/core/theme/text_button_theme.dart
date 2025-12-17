import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppTextButtonTheme {
  AppTextButtonTheme._();

  static final TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.textTertiary,
      textStyle: AppTextTheme.lightTextTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}

