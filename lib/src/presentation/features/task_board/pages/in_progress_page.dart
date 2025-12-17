import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:task_tracker_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_state.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/widgets/task_card.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskManagerCubit, TaskManagerState>(
      listener: (context, state) {
        if (state.status == TaskStatus.failure) {
          context.showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        final inProgressTasks = state.inProgressTasks;
        return Scaffold(
          backgroundColor: AppColors.screenBackground,
          body: inProgressTasks.isEmpty
              ? const CenterMessageWidget(message: 'No Task Available')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: inProgressTasks.length,
                  itemBuilder: (context, index) {
                    final task = inProgressTasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TaskCard(task: task),
                    );
                  },
                ),
        );
      },
    );
  }
}
