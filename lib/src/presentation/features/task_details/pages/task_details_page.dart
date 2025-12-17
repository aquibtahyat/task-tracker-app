import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/formatter/time_formatter.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/domain/enums/task_type.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/manager/get_comments/get_comments_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/widgets/comments_section.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/widgets/task_type_chip.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.task});

  final TaskEntity task;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  void initState() {
    super.initState();
    _getComments();
  }

  Future<void> _getComments() async {
    if (widget.task.id != null) {
      context.read<GetCommentsCubit>().getComments(widget.task.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLabel = widget.task.getCurrentLabel();
    final statusText = currentLabel.displayName;
    final statusColor = _getStatusColor(currentLabel);

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(title: const Text('Task Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.content ?? 'Untitled Task',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            TaskTypeChip(statusText: statusText, statusColor: statusColor),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.task.description ?? 'No description provided',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            if (widget.task.getCurrentLabel() == TaskType.done &&
                widget.task.updatedAt != null &&
                widget.task.updatedAt!.isNotEmpty) ...[
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Completed at ${TimeFormatter.formatDateTime(widget.task.updatedAt)}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.mediumGrey,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            const Divider(color: AppColors.borderMedium, thickness: 1),
            if (widget.task.id != null)
              CommentsSection(taskId: widget.task.id!),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TaskType taskType) {
    switch (taskType) {
      case TaskType.todo:
        return AppColors.todoBlue;
      case TaskType.inProgress:
        return AppColors.inProgressOrange;
      case TaskType.done:
        return AppColors.doneGreen;
    }
  }
}
