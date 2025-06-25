//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/generate_otp_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GenerateOtpRemote {
  final Dio _dio;

  const GenerateOtpRemote(Dio dio) : _dio = dio;

  //* Get All GenerateOtp
  Future<GenerateOtpModel> getAllGenerateOtp() {
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
