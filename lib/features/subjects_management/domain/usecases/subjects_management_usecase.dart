//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../shared/entities/role.dart' show Role;
import '../../data/models/subjects_management_model.dart'
    show FacultySubjects, Subject, UniversitySubjects;
import '../repositories/subjects_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementUsecase {
  final SubjectsManagementRepo _repo;

  SubjectsManagementUsecase({
    required SubjectsManagementRepo repo,
  }) : _repo = repo;

  //* Get All SubjectsManagement
  Future<Either<String, FacultySubjects>> getSuperAdminSubjects(
          {required int year, required String majorId}) =>
      _repo.getSuperAdminSubjects(year: year, majorId: majorId);

  Future<Either<String, UniversitySubjects>> getProfessorSubjects() =>
      _repo.getProfessorSubjects();

  Future<Either<String, Subject>> getSubjectById(String id, Role role) =>
      _repo.getSubjectById(id, role);
}
