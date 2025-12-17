import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.strokeWidth = 4, this.size = 24});

  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
