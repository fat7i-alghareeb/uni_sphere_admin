//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../grade_management/data/param/assign_one_time_code.dart' show AssignOneTimeCode;

//!----------------------------  The Class  ------------------------------  -------!//

abstract class GenerateOtpRepo {
  GenerateOtpRepo();

  //* Assign One Time Code To Student
  Future<Either<String, void>> assignOneTimeCodeToStudent(AssignOneTimeCode assignOneTimeCode);

  //* Assign One Time Code To Professor
  Future<Either<String, void>> assignOneTimeCodeToProfessor(AssignOneTimeCode assignOneTimeCode);
}
