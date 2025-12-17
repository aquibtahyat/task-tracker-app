import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';

class TaskTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TaskTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: _getTabColor(index),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _getTabLabel(index),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _getTextColor(index),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getTabColor(int index) {
    if (currentIndex == index) {
      switch (index) {
        case 0:
          return AppColors.todoBlue;
        case 1:
          return AppColors.inProgressOrange;
        case 2:
          return AppColors.doneGreen;
        default:
          return AppColors.todoBlue;
      }
    }
    return AppColors.surfaceBackground;
  }

  Color _getTextColor(int index) {
    return currentIndex == index ? AppColors.textWhite : AppColors.textPrimary;
  }

  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return 'To Do';
      case 1:
        return 'In Progress';
      case 2:
        return 'Done';
      default:
        return '';
    }
  }
}
