//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../generate_otp/data/param/subject_grade.dart' show SubjectGrade;
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradeManagementRemote {
  final Dio _dio;

  const GradeManagementRemote(Dio dio) : _dio = dio;

  //* Get All GradeManagement
  Future<void> assignGradesToSubject(SubjectGrade subjectGrade) {
    return throwDioException(
      () async {
        final response = await _dio.post(
          AppUrl.assignGradesToSubject,
          data: subjectGrade.toJson(),
        );
        return response.data;
      },
    );
  }
}
