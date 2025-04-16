//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/questions_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class QuestionsRemote {
  final Dio _dio;

  const QuestionsRemote(Dio dio) : _dio = dio;

  //* Get All Questions
  Future<QuestionsModel> getAllQuestions() {
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
