//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import 'package:uni_sphere_admin/features/timetable_management/data/param/create_schedule.dart';
import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/day_schedule_model.dart' show DayScheduleModel;
import '../models/moth_schedule_model.dart' show MothScheduleModel;
import '../param/add_lecutre.dart' show AddLectureParam;

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

  Future<DayScheduleModel> addLecture(AddLectureParam param) {
    return throwDioException(
      () async {
        final response =
            await _dio.post(AppUrl.addLecture, data: param.toJson());
        return DayScheduleModel.fromJson(response.data);
      },
    );
  }

  Future<MothScheduleModel> createSchedule(CreateSchedule param) {
    return throwDioException(
      () async {
        final response = await _dio.post(AppUrl.createSchedule, data: param.toJson());
        return MothScheduleModel.fromJson(response.data);
      },
    );
  }
}
