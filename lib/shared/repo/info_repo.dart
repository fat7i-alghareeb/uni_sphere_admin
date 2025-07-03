import 'package:fpdart/fpdart.dart' show Either;
import 'package:uni_sphere_admin/shared/services/exception/error_handler.dart'
    show throwAppException;
import '../entities/faculty.dart' show Faculty;
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
}
