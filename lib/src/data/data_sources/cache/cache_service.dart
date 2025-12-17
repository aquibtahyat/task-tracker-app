import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_service.dart';

enum CacheKey { timeTracking }

abstract class CacheService {
  Future<void> save<T>(String key, T value);

  T? get<T>(String key);

  Future<void> remove(List<String> keys);

  Future<void> clear();
}
