//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../shared/entities/role.dart' show Role;
import '../../data/models/subjects_management_model.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsManagementRepo {
  SubjectsManagementRepo();

  //* Get All SubjectsManagement
  Future<Either<String, FacultySubjects>> getSuperAdminSubjects({required int year, required String majorId});
  Future<Either<String, UniversitySubjects>> getProfessorSubjects();
  Future<Either<String, Subject>> getSubjectById(String id, Role role);
}
