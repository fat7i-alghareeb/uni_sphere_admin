//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/announcements_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementRemote {
  final Dio _dio;

  const AnnouncementsManagementRemote(Dio dio) : _dio = dio;

  //* Get All AnnouncementsManagement
  Future<AnnouncementsManagementModel> getAllAnnouncementsManagement() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          "random/url",
        );
        return response.data;
      },
    );
  }
}
