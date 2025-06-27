//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart' show Role;
import '../datasources/subjects_management_remote_data_source.dart';
import '../../domain/repositories/subjects_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';
import '../models/subjects_management_model.dart' show FacultySubjects, Subject, UniversitySubjects;

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementRepoImp implements SubjectsManagementRepo {
  final SubjectsManagementRemote _remote;

  SubjectsManagementRepoImp({
    required SubjectsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, FacultySubjects>> getSuperAdminSubjects({required int year, required String majorId}) {
      return throwAppException(
      () async {
        return await _remote.getSuperAdminSubjects(
            year: year, majorId: majorId);
      },
    );
  }

  @override
  Future<Either<String, UniversitySubjects>> getProfessorSubjects() {
    return throwAppException(
      () async {
        return await _remote.getProfessorSubjects();
      },
    );
  }

  @override
  Future<Either<String, Subject>> getSubjectById(String id, Role role) {
    return throwAppException(
      () async {
        return await _remote.getSubjectById(id, role);
      },
    );
  }
}
