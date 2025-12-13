import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';

class AppFABTheme {
  AppFABTheme._();

  static final FloatingActionButtonThemeData lightFABTheme =
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        enableFeedback: true,
      );
}
