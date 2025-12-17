import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/src/core/routes/routes.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/formatter/time_formatter.dart';
import 'package:task_tracker_app/src/core/utils/widgets/dialog_widget.dart';
import 'package:task_tracker_app/src/core/utils/widgets/loading_widget.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/enums/task_type.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_state.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/timer_tracker/time_tracker_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/widgets/task_timer_widget.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final currentLabel = task.getCurrentLabel();
    final taskManagerState = context.watch<TaskManagerCubit>().state;
    final hasLoadingTasks = taskManagerState.loadingTaskIds.isNotEmpty;
    final isLoading =
        task.id != null && taskManagerState.loadingTaskIds.contains(task.id);

    return GestureDetector(
      onTap: hasLoadingTasks
          ? null
          : () {
              context.push(AppRoutes.taskDetails, extra: task);
            },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      task.content ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (currentLabel != TaskType.done)
                    isLoading
                        ? const LoadingWidget(size: 16, strokeWidth: 2)
                        : GestureDetector(
                            onTap: hasLoadingTasks
                                ? null
                                : () {
                                    context.push(
                                      AppRoutes.taskForm,
                                      extra: task,
                                    );
                                  },
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: AppColors.mediumGrey,
                            ),
                          ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    task.description ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TaskTimerWidget(taskId: task.id, status: currentLabel),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (currentLabel == TaskType.todo)
                        TextButton.icon(
                          onPressed: hasLoadingTasks
                              ? null
                              : () {
                                  _handleStatusChange(
                                    context,
                                    TaskType.inProgress,
                                  );
                                },
                          icon: const Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            'Start',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      if (currentLabel == TaskType.inProgress) ...[
                        TextButton.icon(
                          onPressed: hasLoadingTasks
                              ? null
                              : () {
                                  _handleStatusChange(context, TaskType.todo);
                                },
                          icon: const Icon(
                            Icons.pause,
                            size: 16,
                            color: AppColors.warning,
                          ),
                          label: Text(
                            'Pause',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.warning),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: hasLoadingTasks
                              ? null
                              : () {
                                  _handleStatusChange(context, TaskType.done);
                                },
                          icon: const Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: AppColors.success,
                          ),
                          label: Text(
                            'Done',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.success),
                          ),
                        ),
                      ],
                      if (currentLabel == TaskType.done)
                        Text(
                          task.updatedAt != null && task.updatedAt!.isNotEmpty
                              ? TimeFormatter.formatDateTime(task.updatedAt)
                              : '',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.mediumGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleStatusChange(
    BuildContext context,
    TaskType newStatus,
  ) async {
    if (task.id == null) return;

    final taskManagerCubit = context.read<TaskManagerCubit>();
    final timeTrackerCubit = context.read<TimeTrackerCubit>();

    final previousState = taskManagerCubit.state;
    final previousInProgressTaskIds = previousState.inProgressTasks
        .map((t) => t.id)
        .whereType<String>()
        .toSet();

    if (newStatus == TaskType.inProgress) {
      if (previousState.inProgressTasks.isNotEmpty) {
        final existingTask = previousState.inProgressTasks.first;

        final confirmed = await ShowDialog.yesNo(
          context,
          'Task Already In Progress',
          message:
              'You already have a task in progress. Moving this task to in progress will move that task back to to do. Do you want to continue?',
          yesText: 'Yes, Continue',
          noText: 'Cancel',
        );

        if (confirmed != true) {
          return;
        }
      }
    }
    await taskManagerCubit.moveTask(task, newStatus);

    final currentState = taskManagerCubit.state;
    final isSuccess = currentState.status == TaskStatus.success;

    if (isSuccess) {
      final currentInProgressTaskIds = currentState.inProgressTasks
          .map((t) => t.id)
          .whereType<String>()
          .toSet();

      for (final taskId in currentInProgressTaskIds) {
        if (!previousInProgressTaskIds.contains(taskId)) {
          await timeTrackerCubit.updateTimer(
            taskId,
            DateTime.now().toIso8601String(),
          );
        }
      }
      for (final taskId in previousInProgressTaskIds) {
        if (!currentInProgressTaskIds.contains(taskId)) {
          await timeTrackerCubit.updateTimer(taskId, null);
        }
      }
    }
  }
}
