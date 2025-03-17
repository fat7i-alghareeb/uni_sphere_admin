// 📦 Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../storage_service.dart';

// 🌎 Project imports:

class SecureStorageImp<T extends SecureStorage> implements StorageService<T> {
  final FlutterSecureStorage _secureStorage;

  SecureStorageImp(this._secureStorage);

  @override
  getBool(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : value.toLowerCase() == 'true';
  }

  @override
  getInt(String key) async {
    final value = await _secureStorage.read(key: key);
    return value == null ? null : int.tryParse(value);
  }

  @override
  getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  setBool(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  setInt(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  setString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  getStringList(String key) async {
    final value = await _secureStorage.read(key: key);
    return value?.split(',');
  }

  @override
  setStringList(String key, List<String> value) async {
    await _secureStorage.write(key: key, value: value.join(','));
  }

  @override
  remove(String key) async {
    await _secureStorage.delete(key: key);
  }
}
