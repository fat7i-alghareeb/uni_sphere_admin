import 'package:fpdart/fpdart.dart' show Either;
import 'package:uni_sphere_admin/shared/services/exception/error_handler.dart'
    show throwAppException;
import '../entities/admin.dart' show Admin;
import '../entities/faculty.dart' show Faculty;
import '../entities/professor.dart' show Professor;
import '../entities/student_info.dart' show StudentInfo;
import '../entities/subject_info.dart' show SubjectInfo;
import '../remote/info_remote.dart' show InfoRemote;

import '../entities/major.dart' show Major;

class InfoRepo {
  final InfoRemote _infoRemote;

  InfoRepo({required InfoRemote infoRemote}) : _infoRemote = infoRemote;

  Future<Either<String, List<Faculty>>> getFaculties() async {
    return await throwAppException(
      () async {
        return await _infoRemote.getFaculties();
      },
    );
  }

  Future<Either<String, List<Major>>> getMajors(
      {required String facultyId}) async {
    return await throwAppException(
      () async {
        return await _infoRemote.getMajors(facultyId: facultyId);
      },
    );
  }

  Future<Either<String, List<Major>>> getSuperAdminMajors() async {
    return await throwAppException(
      () async {
        return await _infoRemote.getSuperAdminMajors();
      },
    );
  }

  Future<Either<String, List<SubjectInfo>>> getMyMajorSubjects(
      {required int year}) async {
    return await throwAppException(
      () async {
        return await _infoRemote.getMyMajorSubjects(year: year);
      },
    );
  }

  Future<Either<String, List<StudentInfo>>> getStudentForSubject(
      {required String subjectId}) async {
    return await throwAppException(
      () async {
        return await _infoRemote.getStudentForSubject(subjectId: subjectId);
      },
    );
  }

  Future<Either<String, List<Professor>>> getProfessors() async {
    return await throwAppException(
      () async {
        return await _infoRemote.getProfessors();
      },
    );
  }

  Future<Either<String, StudentInfo>> getUnregisteredStudentsByMajor(
      {required String studentNumber}) async {
    return await throwAppException(
      () async {
        return await _infoRemote.getUnregisteredStudentsByMajor(studentNumber: studentNumber);
      },
    );
  }

  Future<Either<String, List<Admin>>> getUnregisteredAdminsByFaculty() async {
    return await throwAppException(
      () async {
        return await _infoRemote.getUnregisteredAdminsByFaculty();
      },
    );
  }

  Future<Either<String, List<SubjectInfo>>> getUnassignedSubjects(
      {required String majorId, required int majorYear}) async {
    return await throwAppException(
      () async {
        return await _infoRemote.getUnassignedSubjects(majorId: majorId, majorYear: majorYear);
      },
    );
  }
}

