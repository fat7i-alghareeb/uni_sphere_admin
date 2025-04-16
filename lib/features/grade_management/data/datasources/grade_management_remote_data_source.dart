//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/grade_management_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradeManagementRemote {
  final Dio _dio;

  const GradeManagementRemote(Dio dio) : _dio = dio;

  //* Get All GradeManagement
  Future<GradeManagementModel> getAllGradeManagement() {
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
