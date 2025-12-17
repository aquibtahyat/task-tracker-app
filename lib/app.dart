import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/src/core/injection/injector.dart';
import 'package:task_tracker_app/src/core/routes/router.dart';
import 'package:task_tracker_app/src/core/theme/app_theme.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/get_tasks/get_tasks_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/task_manager/task_manager_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/manager/timer_tracker/time_tracker_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/manager/get_comments/get_comments_cubit.dart';
import 'package:task_tracker_app/src/presentation/features/task_form/manager/task_form/task_form_cubit.dart';

import 'src/presentation/features/task_details/manager/add_comment/add_comment_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTasksCubit>(create: (_) => injector<GetTasksCubit>()),
        BlocProvider<TaskManagerCubit>(
          create: (_) => injector<TaskManagerCubit>(),
        ),
        BlocProvider<TimeTrackerCubit>(
          create: (_) => injector<TimeTrackerCubit>(),
        ),
        BlocProvider<TaskFormCubit>(create: (_) => injector<TaskFormCubit>()),
        BlocProvider<GetCommentsCubit>(
          create: (_) => injector<GetCommentsCubit>(),
        ),
        BlocProvider<AddCommentCubit>(
          create: (_) => injector<AddCommentCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.instance.router,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
