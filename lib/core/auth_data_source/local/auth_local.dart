// 🎯 Dart imports:
import 'dart:convert';

// 🌎 Project imports:

import 'package:uni_sphere_admin/shared/utils/helper/colored_print.dart';

import '../../../shared/entities/user.dart';
import '../../../shared/utils/storage_service/storage_service.dart';
import '../../constants/key_constants.dart';

class AuthLocal {
  final StorageService local;

  AuthLocal({required this.local});

  ///***************** user Storage **************
  Future<void> setUser(User value) async {
    printR("saving user ${value.toMap()}");
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
    printR("getting user");
    final String? string = local.getString(kUserInfo);
    if (string != null) {
      Map<String, dynamic> d = json.decode(string);
      User user = User.fromMap(d);
      printR("user: ${user.toMap()}");
      return user;
    }
    return null;
  }
}
