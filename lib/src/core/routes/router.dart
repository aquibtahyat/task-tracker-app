import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/src/core/routes/routes.dart';
import 'package:task_tracker_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:task_tracker_app/src/domain/entities/task_entity.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/pages/done_page.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/pages/home_shell_page.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/pages/in_progress_page.dart';
import 'package:task_tracker_app/src/presentation/features/task_board/pages/to_do_page.dart';
import 'package:task_tracker_app/src/presentation/features/task_form/pages/task_form_page.dart';
import 'package:task_tracker_app/src/presentation/features/task_details/pages/task_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

class AppRouter {
  AppRouter._();

  static final instance = AppRouter._();

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.todo,
    navigatorKey: _rootNavigatorKey,
    routes: _routes,
    errorBuilder: (context, state) =>
        const CenterMessageWidget(message: 'Page not found'),
  );

  List<RouteBase> get _routes => [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeShellPage(statefulNavigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.todo,
              builder: (context, state) => const TodoPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.inProgress,
              builder: (context, state) => const InProgressPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.done,
              builder: (context, state) => const DonePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.taskForm,
      builder: (context, state) {
        final task = state.extra as TaskEntity?;
        return TaskFormPage(task: task);
      },
    ),
    GoRoute(
      path: AppRoutes.taskDetails,
      builder: (context, state) {
        final task = state.extra as TaskEntity;
        return TaskDetailsPage(task: task);
      },
    ),
  ];
}
