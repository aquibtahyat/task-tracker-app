import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppDialogTheme {
  AppDialogTheme._();

  static final DialogThemeData lightDialogTheme = DialogThemeData(
    backgroundColor: AppColors.surfaceBackground,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    titleTextStyle: AppTextTheme.lightTextTheme.titleLarge,
    contentTextStyle: AppTextTheme.lightTextTheme.bodyMedium,
    alignment: Alignment.center,
    insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}
