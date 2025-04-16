//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/home_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class HomeRemote {
  final Dio _dio;

  const HomeRemote(Dio dio) : _dio = dio;

  //* Get All Home
  Future<HomeModel> getAllHome() {
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
