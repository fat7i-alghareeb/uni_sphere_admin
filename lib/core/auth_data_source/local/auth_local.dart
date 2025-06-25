// 🎯 Dart imports:
import 'dart:convert';

// 🌎 Project imports:

import '../../../shared/entities/user.dart';
import '../../../shared/utils/storage_service/storage_service.dart';
import '../../constants/key_constants.dart';

class AuthLocal {
  final StorageService local;

  AuthLocal({required this.local});

  ///***************** user Storage **************
  Future<void> setUser(User value) async {
    await local.setString(kUserInfo, jsonEncode(value.toMap()));
  }

  // bool isAuthenticated() {
  //   final String? string = local.getString(kUserInfo);
  //   return string != null && string.isNotEmpty;
  // }

  removeUser() async {
    await local.remove(kUserInfo);
  }

  User? getUser() {
    final String? string = local.getString(kUserInfo);
    if (string != null) {
      Map<String, dynamic> d = json.decode(string);
      User user = User.fromMap(d);
      return user;
    }
    return null;
  }
}
