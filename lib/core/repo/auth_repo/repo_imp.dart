// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/access/data/params/check_one_time_param.dart';
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
  Future<Either<String, FullUser>> loginAdmin({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.loginAdmin(loginParam: loginParam);
      _saveUser(
        response,
        refreshToken: response.refreshToken,
        accessToken: response.accessToken,
      );
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> loginProfessor({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.loginProfessor(loginParam: loginParam);
      _saveUser(
        response,
        refreshToken: response.refreshToken,
          accessToken: response.accessToken,
      );
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> loginSuperAdmin({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.loginSuperAdmin(loginParam: loginParam);
      _saveUser(response, refreshToken: response.refreshToken, accessToken: response.accessToken);
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> loginSystemController({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.loginSystemController(loginParam: loginParam);
      _saveUser(response, refreshToken: response.refreshToken, accessToken: response.accessToken);
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> registerProfessor(
      {required RegisterParam registerParam}) {
    return throwAppException(() async {
      final response = await remote.registerProfessor(registerParam: registerParam);
      _saveUser(response, refreshToken: response.refreshToken, accessToken: response.accessToken);
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> registerSuperAdmin(
      {required RegisterParam registerParam}) {
    return throwAppException(() async {
      final response = await remote.registerSuperAdmin(registerParam: registerParam);
      _saveUser(response, refreshToken: response.refreshToken, accessToken: response.accessToken);
      return response;
    });
  }
  @override
  Future<Either<String, FullUser>> registerAdmin(
      {required RegisterParam registerParam}) {
    return throwAppException(() async {
      final response = await remote.registerAdmin(registerParam: registerParam);
      _saveUser(response, refreshToken: response.refreshToken, accessToken: response.accessToken);
      return response;
    });
  }

  _saveUser(FullUser user, {required String? refreshToken, String? accessToken}) {
    reactiveTokenStorage.write(
      AuthTokenModel(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
      ),
    );
    storageService.setUser(user);
  }

  @override
  Future<Either<String, String>> checkOneTimeCodeSuperAdmin({required CheckOneTimeParam checkOneTimeParam}) {
    return throwAppException(() async {
      final response = await remote.checkOneTimeCodeSuperAdmin(checkOneTimeParam: checkOneTimeParam);
      return response;
    });
  }
  @override
  Future<Either<String, String>> checkOneTimeCodeProfessor({required CheckOneTimeParam checkOneTimeParam}) {
    return throwAppException(() async {
      final response = await remote.checkOneTimeCodeProfessor(checkOneTimeParam: checkOneTimeParam);
      return response;
    });
  }
  @override
  Future<Either<String, String>> checkOneTimeCodeAdmin({required CheckOneTimeParam checkOneTimeParam}) {
    return throwAppException(() async {
      final response = await remote.checkOneTimeCodeAdmin(checkOneTimeParam: checkOneTimeParam);
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
