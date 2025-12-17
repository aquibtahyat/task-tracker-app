import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/formatter/time_formatter.dart';
import 'package:task_tracker_app/src/domain/enums/task_type.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/timer_tracker/time_tracker_cubit.dart';

class TaskTimerWidget extends StatelessWidget {
  final String? taskId;
  final TaskType status;

  const TaskTimerWidget({
    super.key,
    required this.taskId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (taskId == null) return const SizedBox.shrink();

    return BlocBuilder<TimeTrackerCubit, BaseState>(
      builder: (context, state) {
        if (state is! SuccessState) return const SizedBox.shrink();

        final timerData = context.read<TimeTrackerCubit>().getTimer(taskId!);

        if (timerData == null) return const SizedBox.shrink();

        final elapsedSeconds = timerData.currentElapsedSeconds();
        if (elapsedSeconds == 0) return const SizedBox.shrink();

        final timeString = TimeFormatter.formatDuration(elapsedSeconds);
        final isRunning = timerData.isRunning();
        if (status == TaskType.inProgress && isRunning) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_sharp, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                timeString,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time,
              size: 14,
              color: AppColors.mediumGrey,
            ),
            const SizedBox(width: 4),
            Text(
              timeString,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.mediumGrey),
            ),
          ],
        );
      },
    );
  }
}
