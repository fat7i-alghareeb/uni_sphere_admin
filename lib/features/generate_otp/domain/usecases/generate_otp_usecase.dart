//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../grade_management/data/param/assign_one_time_code.dart' show AssignOneTimeCode;
import '../repositories/generate_otp_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GenerateOtpUsecase {
  final GenerateOtpRepo _repo;

  GenerateOtpUsecase({
    required GenerateOtpRepo repo,
  }) : _repo = repo;

  //* Assign One Time Code To Student
  Future<Either<String, void>> assignOneTimeCodeToStudent(AssignOneTimeCode assignOneTimeCode) =>
      _repo.assignOneTimeCodeToStudent(assignOneTimeCode);

  //* Assign One Time Code To Professor
  Future<Either<String, void>> assignOneTimeCodeToProfessor(AssignOneTimeCode assignOneTimeCode) =>
      _repo.assignOneTimeCodeToProfessor(assignOneTimeCode);
}
