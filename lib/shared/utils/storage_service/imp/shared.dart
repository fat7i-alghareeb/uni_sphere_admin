// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

import '../storage_service.dart';

// 🌎 Project imports:

class StorageServiceSharedImp<T extends SharedStorage>
    implements StorageService<T> {
  final SharedPreferences? _sharedPreferences;

  StorageServiceSharedImp(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  @override
  bool? getBool(String key) {
    return _sharedPreferences!.getBool(key);
  }

  @override
  int? getInt(String key) {
    return _sharedPreferences!.getInt(key);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  @override
  Future setBool(String key, bool value) async {
    await _sharedPreferences!.setBool(key, value);
  }

  @override
  Future setInt(String key, int value) async {
    await _sharedPreferences!.setInt(key, value);
  }

  @override
  Future setString(String key, String value) async {
    await _sharedPreferences!.setString(key, value);
    await _sharedPreferences!.reload();
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    await _sharedPreferences!.reload();
    return _sharedPreferences!.getStringList(key);
  }

  @override
  remove(String key) async {
    await _sharedPreferences!.remove(key);
  }

  @override
  Future setStringList(String key, List<String> value) async {
    await _sharedPreferences!.setStringList(key, value);
    await _sharedPreferences!.reload();
  }
}
