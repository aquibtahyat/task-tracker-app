part of 'cache_service.dart';

@LazySingleton(as: CacheService)
class SharedPreferencesService implements CacheService {
  SharedPreferencesService(this.prefs);

  final SharedPreferences prefs;

  @override
  Future<void> save<T>(String key, T value) async {
    switch (T) {
      case const (String):
        await prefs.setString(key, value as String);
        break;
      case const (int):
        await prefs.setInt(key, value as int);
        break;
      case const (bool):
        await prefs.setBool(key, value as bool);
        break;
      case const (double):
        await prefs.setDouble(key, value as double);
        break;
      case const (Map<String, dynamic>):
        await prefs.setString(key, jsonEncode(value as Map<String, dynamic>));
        break;
      default:
        await prefs.setString(key, value as String);
    }
  }

  @override
  T? get<T>(String key) {
    return switch (T) {
      const (String) => prefs.getString(key) as T?,
      const (int) => prefs.getInt(key) as T?,
      const (bool) => prefs.getBool(key) as T?,
      const (double) => prefs.getDouble(key) as T?,
      const (Map<String, dynamic>) => 
        prefs.getString(key) != null 
          ? jsonDecode(prefs.getString(key)!) as T?
          : null,
      _ => prefs.get(key) as T?,
    };
  }

  @override
  Future<void> remove(List<String> keys) async {
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  @override
  Future<void> clear() async {
    await prefs.clear();
  }
}
