//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../../core/constants/app_url.dart';
import '../models/announcement_model.dart';
import '../params/create_faculty_announcement_param.dart';
import '../params/create_major_announcement_param.dart';
import '../../../../shared/services/exception/error_handler.dart';
import 'package:flutter/foundation.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementRemote {
  final Dio _dio;

  const AnnouncementsManagementRemote(Dio dio) : _dio = dio;

  Future<List<AnnouncementModel>> getAdminAnnouncements({int? year}) async {
    return throwDioException(() async {
      final Map<String, dynamic> queryParameters = {};
      if (year != null) {
        queryParameters['year'] = year;
      }

      debugPrint('🔍 Remote: Calling Admin announcements API with year: $year');
      final response = await _dio.get(
        AppUrl.getAdminAnnouncements,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );
      debugPrint(
          '🔍 Remote: Admin API response status: ${response.statusCode}');
      debugPrint('🔍 Remote: Admin API response data: ${response.data}');
      List<dynamic> data = response.data["announcements"];
      debugPrint('🔍 Remote: Parsed Admin announcements data: $data');
      final result = data.map((e) => AnnouncementModel.fromMap(e)).toList();
      debugPrint('🔍 Remote: Mapped ${result.length} Admin announcements');
      return result;
    });
  }

  Future<List<AnnouncementModel>> getSuperAdminAnnouncements() async {
    return throwDioException(() async {
      debugPrint('🔍 Remote: Calling SuperAdmin announcements API');
      final response = await _dio.get(AppUrl.getSuperAdminAnnouncements);
      debugPrint(
          '🔍 Remote: SuperAdmin API response status: ${response.statusCode}');
      debugPrint('🔍 Remote: SuperAdmin API response data: ${response.data}');
      List<dynamic> data = response.data["announcements"];
      debugPrint('🔍 Remote: Parsed announcements data: $data');
      final result =
          data.map((e) => AnnouncementModel.fromSuperAdminMap(e)).toList();
      debugPrint('🔍 Remote: Mapped ${result.length} announcements');
      return result;
    });
  }

  Future<void> createFacultyAnnouncement(
      CreateFacultyAnnouncementParam param) async {
    return throwDioException(() async {
      debugPrint('🔍 Remote: Creating faculty announcement');
      final formData = FormData.fromMap(param.toFormData());

      final response =
          await _dio.post(AppUrl.createFacultyAnnouncement, data: formData);

      debugPrint('🔍 Remote: Faculty announcement created successfully');
      debugPrint('🔍 Remote: Response status: ${response.statusCode}');
      return response.data;
    });
  }

  Future<void> createMajorAnnouncement(
      CreateMajorAnnouncementParam param) async {
    return throwDioException(() async {
      debugPrint('🔍 Remote: Creating major announcement');

      final response = await _dio.post(
        AppUrl.createMajorAnnouncement,
        data: param.toJson(),
      );

      debugPrint('🔍 Remote: Major announcement created successfully');
      debugPrint('🔍 Remote: Response status: ${response.statusCode}');
      return response.data;
    });
  }
}
