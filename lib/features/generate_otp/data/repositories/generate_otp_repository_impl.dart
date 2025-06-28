//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../grade_management/data/param/assign_one_time_code.dart' show AssignOneTimeCode;
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
  Future<Either<String, void>> assignOneTimeCodeToStudent(AssignOneTimeCode assignOneTimeCode) {
    return throwAppException(
      () async {
        return await _remote.assignOneTimeCodeToStudent(assignOneTimeCode);
      },
    );
  }

  @override
  Future<Either<String, void>> assignOneTimeCodeToProfessor(AssignOneTimeCode assignOneTimeCode) {
    return throwAppException(
      () async {
        return await _remote.assignOneTimeCodeToProfessor(assignOneTimeCode);
      },
    );
  }
}
