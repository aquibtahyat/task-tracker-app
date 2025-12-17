import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_tracker_app/src/core/injection/injector.dart';

class DependencyManager {
  static Future<void> inject() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    injector.registerSingleton<SharedPreferences>(sharedPreferences);
    await configureDependencies();
  }
}
