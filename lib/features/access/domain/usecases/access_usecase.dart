//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:uni_sphere_admin/core/repo/auth_repo/auth_repo.dart' show AuthRepository;
import 'package:uni_sphere_admin/features/access/data/params/login_param.dart' show LoginParam;
import 'package:uni_sphere_admin/shared/entities/user.dart' show User;
import '../../data/params/check_one_time_param.dart' show CheckOneTimeParam;
import '../../data/params/register_param.dart' show RegisterParam;


//!----------------------------  The Class  -------------------------------------!//

class AuthUsecases {
  final AuthRepository _remote;
  AuthUsecases({
    required AuthRepository remote,
  }) : _remote = remote;

  Future<Either<String, User>> loginAdmin({required LoginParam loginParam}) =>
      _remote.loginAdmin(loginParam: loginParam);
  Future<Either<String, User>> loginProfessor({required LoginParam loginParam}) =>
      _remote.loginProfessor(loginParam: loginParam);
  Future<Either<String, User>> loginSuperAdmin({required LoginParam loginParam}) =>
      _remote.loginSuperAdmin(loginParam: loginParam);
  Future<Either<String, User>> loginSystemController({required LoginParam loginParam}) =>
      _remote.loginSystemController(loginParam: loginParam);
  Future<Either<String, String>> checkOneTimeCodeSuperAdmin({required CheckOneTimeParam checkOneTimeParam}) =>
      _remote.checkOneTimeCodeSuperAdmin(checkOneTimeParam: checkOneTimeParam);
  Future<Either<String, String>> checkOneTimeCodeProfessor({required CheckOneTimeParam checkOneTimeParam}) =>
      _remote.checkOneTimeCodeProfessor(checkOneTimeParam: checkOneTimeParam);
  Future<Either<String, String>> checkOneTimeCodeAdmin({required CheckOneTimeParam checkOneTimeParam}) =>
      _remote.checkOneTimeCodeAdmin(checkOneTimeParam: checkOneTimeParam);
  Future<Either<String, User>> registerProfessor({required RegisterParam registerParam}) =>
      _remote.registerProfessor(registerParam: registerParam);
  Future<Either<String, User>> registerSuperAdmin({required RegisterParam registerParam}) =>
      _remote.registerSuperAdmin(registerParam: registerParam);
  Future<Either<String, User>> registerAdmin({required RegisterParam registerParam}) =>
      _remote.registerAdmin(registerParam: registerParam);
}
