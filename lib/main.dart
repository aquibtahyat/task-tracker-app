import 'package:flutter/material.dart';
import 'package:task_tracker_app/app.dart';
import 'package:task_tracker_app/src/core/injection/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyManager.inject();
  runApp(const App());
}
