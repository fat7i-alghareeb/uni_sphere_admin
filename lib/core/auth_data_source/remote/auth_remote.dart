// 📦 Package imports:
import 'package:dio/dio.dart';

import '../../../shared/entities/login_param.dart';
import '../../../shared/entities/user.dart';
import '../../../shared/services/exception/error_handler.dart';
import '../../../shared/services/refresh_token_helper.dart';
import '../../constants/app_url.dart';

// 🌎 Project imports:


class AuthRemote {
  final Dio _dio;

  const AuthRemote(Dio dio) : _dio = dio;

  Future<User> login({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.login,
        data: await loginParam.toJson(),
      );
      return User.fromMap(response.data);
    });
  }

  Future<void> forgetPassword({required String email}) {
    return throwDioException(() async {
      await _dio.post(
        AppUrl.forgetPassword,
        data: {"email": email},
      );
      return;
    });
  }

  Future<void> confirmForgetPassword(
      {required String email, required String code}) {
    return throwDioException(() async {
      await _dio.post(
        AppUrl.confirmForgetPassword,
        data: {
          "email": email,
          "code": code,
        },
      );
      return;
    });
  }

  Future<User> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String deviceToken,
  }) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.resetPassword,
        data: {
          "email": email,
          "code": code,
          "newPassword": newPassword,
          "deviceToken": deviceToken,
        },
      );
      return User.fromMap(response.data);
    });
  }

  Future<String> refreshToken({required User user}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.refreshToken,
        data: {
          "id": user.id,
          "refreshToken": user.refreshToken,
        },
      );
      final accessToken = response.data["accessToken"];
      await updateStorageToken(user, accessToken);
      return accessToken;
    });
  }
}
