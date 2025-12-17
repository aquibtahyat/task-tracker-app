import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/src/core/base/state.dart';
import 'package:task_tracker_app/src/core/theme/app_colors.dart';
import 'package:task_tracker_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:task_tracker_app/src/core/utils/widgets/loading_widget.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/get_tasks/get_tasks_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/timer_tracker/time_tracker_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/widgets/task_tab_bar.dart';

class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  State<HomeShellPage> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<HomeShellPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTasks();
    });
  }

  Future<void> _getTasks() async {
    context.read<GetTasksCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: const Text('Task Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GetTasksCubit>().getTasks();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TaskTabBar(
            currentIndex: widget.statefulNavigationShell.currentIndex,
            onTap: widget.statefulNavigationShell.goBranch,
          ),
          Expanded(
            child: BlocConsumer<GetTasksCubit, BaseState>(
              listenWhen: (_, current) =>
                  current is FailureState || current is SuccessState,

              listener: (context, state) {
                if (state is FailureState) {
                  context.showSnackBar(state.message);
                }
                if (state is SuccessState) {
                  final tasks = state.data;
                  context.read<TaskManagerCubit>().populateTasks(tasks);

                  context.read<TimeTrackerCubit>().retrieveData(tasks);
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const LoadingWidget();
                }
                return widget.statefulNavigationShell;
              },
            ),
          ),
        ],
      ),
    );
  }
}
