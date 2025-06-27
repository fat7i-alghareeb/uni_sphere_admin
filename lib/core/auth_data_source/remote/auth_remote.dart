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

  Future<FullUser> loginAdmin({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginAdmin,
        data: loginParam.toAdminJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<FullUser> loginSuperAdmin({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginSuperAdmin,
        data: loginParam.toSuperAdminJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<FullUser> loginProfessor({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginProfessor,
        data: loginParam.toProfessorJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<FullUser> loginSystemController({required LoginParam loginParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.loginSystemController,
        data: loginParam.toSystemControllerJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<String> checkOneTimeCodeAdmin(
      {required CheckOneTimeParam checkOneTimeParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.checkOneTimeCodeAdmin,
        data: checkOneTimeParam.toAdminJson(),
      );
      return response.data["adminId"];
    });
  }

  Future<String> checkOneTimeCodeSuperAdmin(
      {required CheckOneTimeParam checkOneTimeParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.checkOneTimeCodeSuperAdmin,
        data: checkOneTimeParam.toSuperAdminJson(),
      );
      return response.data["superAdminId"];
    });
  }

  Future<String> checkOneTimeCodeProfessor(
      {required CheckOneTimeParam checkOneTimeParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.checkOneTimeCodeProfessor,
        data: checkOneTimeParam.toProfessorJson(),
      );
      return response.data["professorId"];
    });
  }

  Future<FullUser> registerAdmin({required RegisterParam registerParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.registerAdmin,
        data: registerParam.toAdminJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<FullUser> registerSuperAdmin({required RegisterParam registerParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.registerSuperAdmin,
        data: registerParam.toSuperAdminJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  Future<FullUser> registerProfessor({required RegisterParam registerParam}) {
    return throwDioException(() async {
      final response = await _dio.post(
        AppUrl.registerProfessor,
        data: registerParam.toProfessorJson(),
      );
      return FullUser.fromMap(response.data);
    });
  }

  // Future<void> forgetPassword({required String email}) {
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
