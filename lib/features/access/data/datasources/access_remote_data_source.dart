//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/access_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AccessRemote {
  final Dio _dio;

  const AccessRemote(Dio dio) : _dio = dio;

  //* Get All Access
  Future<AccessModel> getAllAccess() {
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
