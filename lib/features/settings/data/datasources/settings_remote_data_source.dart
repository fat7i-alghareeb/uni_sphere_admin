//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/settings_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SettingsRemote {
  final Dio _dio;

  const SettingsRemote(Dio dio) : _dio = dio;

  //* Get All Settings
  Future<SettingsModel> getAllSettings() {
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
