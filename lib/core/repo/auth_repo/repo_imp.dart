// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/access/data/params/login_param.dart';
import '../../../features/access/data/params/register_param.dart'
    show RegisterParam;
import '../../../shared/entities/user.dart';
import '../../../shared/services/exception/error_handler.dart';
import '../../auth_data_source/local/auth_local.dart';
import '../../auth_data_source/local/reactive_token_storage.dart';
import '../../auth_data_source/remote/auth_remote.dart';
import '../../injection/injection.dart';
import '../../models/auth_token_dio.dart';
import '../auth_repo/auth_repo.dart';

// 🌎 Project imports:

class AuthRepoImp implements AuthRepository {
  final AuthRemote remote;
  final ReactiveTokenStorage reactiveTokenStorage;
  final AuthLocal storageService;

  AuthRepoImp({
    required this.remote,
    required this.reactiveTokenStorage,
    required this.storageService,
  });
  @override
  Stream<AuthStatus> get authStatusStream =>
      reactiveTokenStorage.authenticationStatus;

  @override
  Future<Either<String, FullUser>> login({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.login(loginParam: loginParam);
      final user = User(
        studentId: response.studentId,
        firstName: response.firstName,
        lastName: response.lastName,
        year: response.year,
        majorName: response.majorName,
        studentNumber: response.studentNumber,
        enrollmentStatusName: response.enrollmentStatusName,
        fatherName: response.fatherName,
        numberOfMajorYears: response.numberOfMajorYears,
        image: response.image,
      );
      _saveUser(user,
          refreshToken: response.refreshToken,
          accessToken: response.accessToken);
      return response;
    });
  }

  _saveUser(User user, {required String? refreshToken, String? accessToken}) {
    reactiveTokenStorage.write(
      AuthTokenModel(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
      ),
    );
    storageService.setUser(user);
  }

  // @override
  // Future<Either<String, SimpleUser>> checkOneTimeCode(
  //     {required CheckOneTimeParam checkOneTimeParam}) {
  //   return throwAppException(() async {
  //     final response =
  //         await remote.checkOneTimeCode(checkOneTimeParam: checkOneTimeParam);
  //     return response;
  //   });
  // }

  @override
  Future<Either<String, FullUser>> register(
      {required RegisterParam registerParam}) {
    return throwAppException(() async {
      final response = await remote.register(registerParam: registerParam);
      final user = User(
        studentId: response.studentId,
        firstName: response.firstName,
        lastName: response.lastName,
        year: response.year,
        majorName: response.majorName,
        studentNumber: response.studentNumber,
        enrollmentStatusName: response.enrollmentStatusName,
        fatherName: response.fatherName,
        numberOfMajorYears: response.numberOfMajorYears,
        image: response.image,
      );
      _saveUser(
        user,
        refreshToken: response.refreshToken,
        accessToken: response.accessToken,
      );
      return response;
    });
  }

  @override
  Future<bool> logout() async {
    await storageService.removeUser();
    await reactiveTokenStorage.delete();
    await getIt<FlutterSecureStorage>().deleteAll();
    // await getIt<ReactiveTokenStorage>().loadToken();
    return await getIt<SharedPreferences>().clear();
  }
}
