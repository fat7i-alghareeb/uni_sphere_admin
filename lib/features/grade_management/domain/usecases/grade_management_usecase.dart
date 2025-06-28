//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../generate_otp/data/param/subject_grade.dart' show SubjectGrade;
import '../repositories/grade_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradeManagementUsecase {
  final GradeManagementRepo _repo;

  GradeManagementUsecase({
    required GradeManagementRepo repo,
  }) : _repo = repo;

  //* Assign Grades To Subject
  Future<Either<String, void>> assignGradesToSubject(SubjectGrade subjectGrade) =>
      _repo.assignGradesToSubject(subjectGrade);
}
