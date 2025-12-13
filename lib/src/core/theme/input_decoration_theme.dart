import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppInputDecorationTheme {
  AppInputDecorationTheme._();

  static final InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        errorMaxLines: 3,
        prefixIconColor: AppColors.textTertiary,
        suffixIconColor: AppColors.textTertiary,
        labelStyle: AppTextTheme.lightTextTheme.bodyLarge,
        floatingLabelStyle: AppTextTheme.lightTextTheme.bodyLarge,
        errorStyle: AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
          color: AppColors.error,
        ),
        hintStyle: AppTextTheme.lightTextTheme.bodyMedium,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderMedium, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
      );
}
