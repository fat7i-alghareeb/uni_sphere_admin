//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/generate_otp_entity.dart';
import '../datasources/generate_otp_remote_data_source.dart';
import '../../domain/repositories/generate_otp_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GenerateOtpRepoImp implements GenerateOtpRepo {
  final GenerateOtpRemote _remote;

  GenerateOtpRepoImp({
    required GenerateOtpRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, GenerateOtpEntity>> getAllGenerateOtp() {
    return throwAppException(
      () async {
        return await _remote.getAllGenerateOtp();
      },
    );
  }
}
