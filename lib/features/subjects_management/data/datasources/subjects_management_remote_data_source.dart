//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import 'package:uni_sphere_admin/core/constants/app_url.dart' show AppUrl;
import 'package:uni_sphere_admin/shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch;
import '../../../../shared/entities/role.dart' show Role;
import '../models/subjects_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementRemote {
  final Dio _dio;

  const SubjectsManagementRemote(Dio dio) : _dio = dio;

  //* Get All SubjectsManagement
  Future<SuperAdminSubjects> getSuperAdminSubjects(
      {required int year, required String majorId}) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getSuperAdminSubjects,
          queryParameters: {
            'year': year,
            'majorId': majorId,
          },
        );
        return SuperAdminSubjects.fromJson(response.data);
      },
    );
  }

  Future<UniversitySubjects> getProfessorSubjects() {
    return throwDioException(
      () async {
        final response = await _dio.get(AppUrl.getProfessorSubjects);
        return UniversitySubjects.fromJson(response.data);
      },
    );
  }

  Future<Subject> getSubjectById(String id, Role role) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          role == Role.superadmin
              ? AppUrl.getSuperAdminSubjectById(id)
              : AppUrl.getProfessorSubjectById(id),
        );
        return Subject.fromJson(response.data);
      },
    );
  }

  Future<Subject> updateSubject(String id, GlobalPatch patch) {
    return throwDioException(
      () async {
        final response =
            await _dio.patch(AppUrl.updateSubject(id), data: patch.toJson());
        return Subject.fromJson(response.data);
      },
    );
  }

  Future<Subject> uploadMaterial(String id, FormData formData) {
    return throwDioException(
      () async {
        final response = await _dio.post(
          AppUrl.uploadMaterial(id),
          data: formData,
          options: Options(
            sendTimeout: const Duration(minutes: 10),
            receiveTimeout: const Duration(minutes: 10),
          ),
        );
        return Subject.fromJson(response.data);
      },
    );
  }
}
