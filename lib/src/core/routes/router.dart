import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/src/core/routes/routes.dart';
import 'package:task_tracker_app/src/core/utils/widgets/center_message_widget.dart';
import 'package:task_tracker_app/src/presentation/features/home/pages/home_page.dart';

class AppRouter {
  AppRouter._();

  static final instance = AppRouter._();

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: _routes,
    errorBuilder: (context, state) =>
        const CenterMessageWidget(message: 'Page not found'),
  );

  List<GoRoute> get _routes => [
    GoRoute(
      name: 'home',
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ];
}
