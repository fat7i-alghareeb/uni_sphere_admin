import 'package:dio/dio.dart';
import '../entities/faculty.dart' show Faculty;
import '../entities/major.dart' show Major;

import '../../core/constants/app_url.dart' show AppUrl;
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

  Future<List<SubjectInfo>> getMyMajorSubjects() async {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getMyMajorSubjects);
      List<dynamic> data = response.data;
      return data.map((e) => SubjectInfo.fromMap(e)).toList();
    });
  }
}
