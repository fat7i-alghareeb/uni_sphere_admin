//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/profile_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class ProfileRemote {
  final Dio _dio;

  const ProfileRemote(Dio dio) : _dio = dio;

  //* Get All Profile
  Future<ProfileModel> getAllProfile() {
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
