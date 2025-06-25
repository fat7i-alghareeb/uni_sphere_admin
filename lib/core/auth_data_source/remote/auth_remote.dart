// 📦 Package imports:
import 'package:dio/dio.dart';

import '../../../features/access/data/params/check_one_time_param.dart';
import '../../../features/access/data/params/login_param.dart' show LoginParam;
import '../../../features/access/data/params/register_param.dart';
import '../../../shared/entities/user.dart';
import '../../../shared/services/exception/error_handler.dart';
import '../../constants/app_url.dart';

// 🌎 Project imports:

class AuthRemote {
  final Dio _dio;

  const AuthRemote(Dio dio) : _dio = dio;

  Future<FullUser> login({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.login,
        data: loginParam.toJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  // Future<SimpleUser> checkOneTimeCode(
  //     {required CheckOneTimeParam checkOneTimeParam}) {
  //   return throwDioException(() async {
  //     final response = await _dio.post(
  //       AppUrl.checkOneTimeCode,
  //       data: checkOneTimeParam.toJson(),
  //     );
  //     return SimpleUser.fromJson(response.data);
  //   });
  // }

  Future<FullUser> register({required RegisterParam registerParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.register,
        data: registerParam.toJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }
  // Future<void> forgetPassword({required String email}) {
  //   return throwDioException(() async {
  //     await _dio.post(
  //       AppUrl.forgetPassword,
  //       data: {"email": email},
  //     );
  //     return;
  //   });
  // }

  // Future<void> confirmForgetPassword(
  //     {required String email, required String code}) {
  //   return throwDioException(() async {
  //     await _dio.post(
  //       AppUrl.confirmForgetPassword,
  //       data: {
  //         "email": email,
  //         "code": code,
  //       },
  //     );
  //     return;
  //   });
  // }

  // Future<User> resetPassword({
  //   required String email,
  //   required String code,
  //   required String newPassword,
  //   required String deviceToken,
  // }) {
  //   return throwDioException(() async {
  //     final response = await _dio.post(
  //       AppUrl.resetPassword,
  //       data: {
  //         "email": email,
  //         "code": code,
  //         "newPassword": newPassword,
  //         "deviceToken": deviceToken,
  //       },
  //     );
  //     return User.fromMap(response.data);
  //   });
  // }

  // Future<AuthTokenModel> refreshToken({required User user}) {
  //   return throwDioException(() async {
  //     final response = await _dio.post(
  //       AppUrl.refreshToken,
  //       data: {
  //         "refreshToken": user.refreshToken,
  //       },
  //     );
  //         final authTokenModel = AuthTokenModel.fromMap(response.data);
  //     await updateStorageToken(user, authTokenModel);
  //     return AuthTokenModel;
  //   });
  // }
}
