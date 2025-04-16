//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/timetable_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableManagementRemote {
  final Dio _dio;

  const TimetableManagementRemote(Dio dio) : _dio = dio;

  //* Get All TimetableManagement
  Future<TimetableManagementModel> getAllTimetableManagement() {
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
