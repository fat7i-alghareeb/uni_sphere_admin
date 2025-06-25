// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:fpdart/fpdart.dart';

import '../../../features/access/data/params/check_one_time_param.dart' show CheckOneTimeParam;
import '../../../features/access/data/params/login_param.dart' show LoginParam;
import '../../../features/access/data/params/register_param.dart'
    show RegisterParam;
import '../../../shared/entities/user.dart';

// 🌎 Project imports:

abstract class AuthRepository {
  AuthRepository();

  Future<Either<String, User>> login({required LoginParam loginParam});
  // Future<Either<String, SimpleUser>> checkOneTimeCode(
  //     {required CheckOneTimeParam checkOneTimeParam});
  // Future<Either<String, User>> register({required RegisterParam registerParam});

  // Future<Either<String, void>> forgetPassword({required String email});

  // Future<Either<String, void>> confirmForgetPassword(
  //     {required String email, required String code});

  // Future<Either<String, User>> resetPassword({
  //   required String email,
  //   required String code,
  //   required String newPassword,
  // });

  Stream<AuthStatus> get authStatusStream;

  Future<bool> logout();
}
