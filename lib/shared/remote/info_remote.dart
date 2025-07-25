import 'package:dio/dio.dart';
import 'package:uni_sphere_admin/shared/entities/professor.dart';
import '../entities/admin.dart' show Admin;
import '../entities/faculty.dart' show Faculty;
import '../entities/major.dart' show Major;

import '../../core/constants/app_url.dart' show AppUrl;
import '../entities/student_info.dart' show StudentInfo;
import '../entities/subject_info.dart' show SubjectInfo;
import '../services/exception/error_handler.dart' show throwDioException;

class InfoRemote {
  final Dio _dio;

  const InfoRemote(Dio dio) : _dio = dio;

  Future<List<Faculty>> getFaculties() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getFaculties);
      List<dynamic> data = response.data["factories"];
      return data.map((e) => Faculty.fromMap(e)).toList();
    });
  }

  Future<List<Major>> getMajors({required String facultyId}) async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getMajors, queryParameters: {
        'facultyId': facultyId,
      });
      List<dynamic> data = response.data["majors"];
      return data.map((e) => Major.fromMap(e)).toList();
    });
  }

  Future<List<Major>> getSuperAdminMajors() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getSuperAdminMajors);
      List<dynamic> data = response.data["majors"];
      return data.map((e) => Major.fromMap(e)).toList();
    });
  }

  Future<List<SubjectInfo>> getMyMajorSubjects({required int year}) async {
    return throwDioException(() async {
      final response = await _dio
          .get(AppUrl.getMyMajorSubjects, queryParameters: {'year': year});
      List<dynamic> data = response.data;
      return data.map((e) => SubjectInfo.fromMap(e)).toList();
    });
  }

  Future<List<StudentInfo>> getStudentForSubject(
      {required String subjectId}) async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getStudentForSubject(subjectId));
      List<dynamic> data = response.data["students"];
      return data.map((e) => StudentInfo.fromJson(e)).toList();
    });
  }

  Future<List<Professor>> getProfessors() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getProfessorsByFaculty);
      List<dynamic> data = response.data;
      return data.map((e) => Professor.fromMap(e)).toList();
    });
  }

  Future<StudentInfo> getUnregisteredStudentsByMajor(
      {required String studentNumber}) async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getUnregisteredStudentsByMajor,
          queryParameters: {'studentNumber': studentNumber});
      return StudentInfo.fromJson(response.data);
    });
  }

  Future<List<Admin>> getUnregisteredAdminsByFaculty() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getUnregisteredAdminsByFaculty);
      List<dynamic> data = response.data;
      return data.map((e) => Admin.fromMap(e)).toList();
    });
  }

  Future<List<SubjectInfo>> getUnassignedSubjects(
      {required String majorId, required int majorYear}) async {
    return throwDioException(() async {
      final response =
          await _dio.get(AppUrl.getUnassignedSubjects, queryParameters: {
        'majorId': majorId,
        'majorYear': majorYear,
      });
      List<dynamic> data = response.data;
      return data.map((e) => SubjectInfo.fromMap(e)).toList();
    });
  }
}
