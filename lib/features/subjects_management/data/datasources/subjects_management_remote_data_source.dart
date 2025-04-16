//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/subjects_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementRemote {
  final Dio _dio;

  const SubjectsManagementRemote(Dio dio) : _dio = dio;

  //* Get All SubjectsManagement
  Future<SubjectsManagementModel> getAllSubjectsManagement() {
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
