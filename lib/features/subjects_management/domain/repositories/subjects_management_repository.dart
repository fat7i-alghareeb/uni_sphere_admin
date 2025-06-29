//!----------------------------  Imports  -------------------------------------!//
import 'dart:io' show File;

import 'package:fpdart/fpdart.dart';
import '../../../../shared/entities/role.dart' show Role;
import '../../../../shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch;
import '../../data/models/subjects_management_model.dart'
    show FacultySubjects, Subject, UniversitySubjects, SuperAdminSubjects;

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsManagementRepo {
  SubjectsManagementRepo();

  //* Get All SubjectsManagement
  Future<Either<String, SuperAdminSubjects>> getSuperAdminSubjects(
      {required int year, required String majorId});
  Future<Either<String, UniversitySubjects>> getProfessorSubjects();
  Future<Either<String, Subject>> getSubjectById(String id, Role role);
  Future<Either<String, Subject>> updateSubject(String id, GlobalPatch patch);
  Future<Either<String, Subject>> uploadMaterial(String id, File formData);
}
