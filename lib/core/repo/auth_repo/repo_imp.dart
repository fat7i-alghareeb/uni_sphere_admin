// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth_repo.dart';

import '../../../shared/entities/login_param.dart';
import '../../../shared/entities/user.dart';
import '../../../shared/services/exception/error_handler.dart';
import '../../auth_data_source/local/auth_local.dart';
import '../../auth_data_source/local/reactive_token_storage.dart';
import '../../auth_data_source/remote/auth_remote.dart';
import '../../injection/injection.dart';
import '../../models/auth_token_dio.dart';

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
  Future<Either<String, User>> login({required LoginParam loginParam}) {
    return throwAppException(() async {
      final response = await remote.login(loginParam: loginParam);
      _saveUser(response);
      return response;
    });
  }

  _saveUser(User user) {
    reactiveTokenStorage.write(AuthTokenModel(
        accessToken: user.accessToken, refreshToken: user.refreshToken));
    storageService.setUser(user);
  }

  @override
  Future<bool> logout() async {
    await storageService.removeUser();
    await reactiveTokenStorage.delete();
    await getIt<FlutterSecureStorage>().deleteAll();
    await getIt<ReactiveTokenStorage>().loadToken();
    return await getIt<SharedPreferences>().clear();
  }

  @override
  Future<Either<String, void>> confirmForgetPassword(
      {required String email, required String code}) {
    return throwAppException(() async {
      final response = await remote.confirmForgetPassword(
        email: email,
        code: code,
      );
      return response;
    });
  }

  @override
  Future<Either<String, void>> forgetPassword({required String email}) {
    return throwAppException(() async {
      final response = await remote.forgetPassword(
        email: email,
      );
      return response;
    });
  }

  @override
  Future<Either<String, User>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    // final String deviceToken =
    //     await FirebaseNotificationImplService().getToken() ?? "";
    return throwAppException(() async {
      final response = await remote.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        deviceToken: "",
      );
      _saveUser(response);
      return response;
    });
  }
}
