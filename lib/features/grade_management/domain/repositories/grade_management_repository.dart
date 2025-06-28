//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../generate_otp/data/param/subject_grade.dart' show SubjectGrade;

//!----------------------------  The Class  -------------------------------------!//

abstract class GradeManagementRepo {
  GradeManagementRepo();

  //* Get All GradeManagement
  Future<Either<String, void>> assignGradesToSubject(SubjectGrade subjectGrade);
}
