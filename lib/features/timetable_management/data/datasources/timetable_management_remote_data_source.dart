//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/moth_schedule_model.dart' show MothScheduleModel;

//!----------------------------  The Class  -------------------------------------!//

class TimetableManagementRemote {
  final Dio _dio;

  const TimetableManagementRemote(Dio dio) : _dio = dio;

  //* Get All Timetable
  Future<MothScheduleModel> getMonthTimetable(
      {required int month, required int year}) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getScheduleByMonth,
          queryParameters: {
            "month": month,
            "year": year,
          },
        );
        return MothScheduleModel.fromJson(response.data);
      },
    );
  }

  Future<MothScheduleModel> getAllTimetables() {
    return throwDioException(
      () async {
        final response = await _dio.get(AppUrl.getMySchedule);
        return MothScheduleModel.fromJson(response.data);
      },
    );
  }
}
