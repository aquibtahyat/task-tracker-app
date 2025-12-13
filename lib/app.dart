import 'package:flutter/material.dart';
import 'package:task_tracker_app/src/core/routes/router.dart';
import 'package:task_tracker_app/src/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.instance.router,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}
