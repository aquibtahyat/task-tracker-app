import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';

class ShowSnackBar {
  ShowSnackBar(
    this.context,
    this.msg, {
    this.isLongDuration = false,
    this.customDuration,
    this.backgroundColor,
    this.textColor,
    this.icon,
  }) {
    _show();
  }

  ShowSnackBar.success(
    this.context,
    this.msg, {
    this.isLongDuration = false,
    this.customDuration,
  }) : backgroundColor = AppColors.success,
       textColor = AppColors.textWhite,
       icon = Icons.check_circle {
    _show();
  }

  ShowSnackBar.error(
    this.context,
    this.msg, {
    this.isLongDuration = false,
    this.customDuration,
  }) : backgroundColor = AppColors.error,
       textColor = AppColors.textWhite,
       icon = Icons.error {
    _show();
  }
  final BuildContext? context;
  final String msg;
  final bool isLongDuration;
  final int? customDuration;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  void _show() {
    if (msg.trim().isEmpty || context == null) return;

    final messenger = ScaffoldMessenger.of(context!);
    messenger.clearSnackBars();

    final duration = Duration(
      seconds: customDuration ?? (isLongDuration ? 8 : 4),
    );

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                msg,
                textAlign: icon != null ? TextAlign.left : TextAlign.center,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
