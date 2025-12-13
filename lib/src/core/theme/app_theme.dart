import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_bar_theme.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/theme/dialog_theme.dart';
import 'package:task_tracker_app/src/core/theme/elevated_button_theme.dart';
import 'package:task_tracker_app/src/core/theme/floating_action_button_theme.dart';
import 'package:task_tracker_app/src/core/theme/input_decoration_theme.dart';
import 'package:task_tracker_app/src/core/theme/text_button_theme.dart';
import 'package:task_tracker_app/src/core/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.screenBackground,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    textButtonTheme: AppTextButtonTheme.lightTextButtonTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: AppFABTheme.lightFABTheme,
    dialogTheme: AppDialogTheme.lightDialogTheme,
  );
}
