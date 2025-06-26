// 📦 Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:fpdart/fpdart.dart';

import '../../../features/access/data/params/check_one_time_param.dart'
    show CheckOneTimeParam;
import '../../../features/access/data/params/login_param.dart' show LoginParam;
import '../../../features/access/data/params/register_param.dart'
    show RegisterParam;
import '../../../shared/entities/user.dart';

// 🌎 Project imports:

abstract class AuthRepository {
  AuthRepository();

  Future<Either<String, User>> loginAdmin({required LoginParam loginParam});
  Future<Either<String, User>> loginProfessor({required LoginParam loginParam});
  Future<Either<String, User>> loginSuperAdmin(
      {required LoginParam loginParam});
  Future<Either<String, User>> loginSystemController(
      {required LoginParam loginParam});
  Future<Either<String, User>> registerAdmin(
      {required RegisterParam registerParam});
  Future<Either<String, User>> registerProfessor(
      {required RegisterParam registerParam});
  Future<Either<String, User>> registerSuperAdmin(
      {required RegisterParam registerParam});

  Future<Either<String, User>> checkOneTimeCodeSuperAdmin(
      {required CheckOneTimeParam checkOneTimeParam});
  Future<Either<String, User>> checkOneTimeCodeProfessor(
      {required CheckOneTimeParam checkOneTimeParam});
  Future<Either<String, User>> checkOneTimeCodeAdmin(
      {required CheckOneTimeParam checkOneTimeParam});

  Stream<AuthStatus> get authStatusStream;

  Future<bool> logout();
}
