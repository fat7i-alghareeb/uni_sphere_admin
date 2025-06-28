//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../grade_management/data/param/assign_one_time_code.dart' show AssignOneTimeCode;
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GenerateOtpRemote {
  final Dio _dio;

  const GenerateOtpRemote(Dio dio) : _dio = dio;

  //* Assign One Time Code To Student
  Future<void> assignOneTimeCodeToStudent(AssignOneTimeCode assignOneTimeCode) {
    return throwDioException(
      () async {
        await _dio.post(AppUrl.assignOneTimeCodeToStudent, data: assignOneTimeCode.toJson());
      },
    );
  }

  //* Assign One Time Code To Professor
  Future<void> assignOneTimeCodeToProfessor(AssignOneTimeCode assignOneTimeCode) {
    return throwDioException(
      ()   async {
        await _dio.post(AppUrl.assignOneTimeCodeToProfessor, data: assignOneTimeCode.toJson());
      },
    );
  }
}
