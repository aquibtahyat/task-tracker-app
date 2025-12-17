import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';

class TaskTypeChip extends StatelessWidget {
  const TaskTypeChip({super.key, this.statusText, this.statusColor});

  final String? statusText;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return statusText == null
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor ?? AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              statusText!,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}
