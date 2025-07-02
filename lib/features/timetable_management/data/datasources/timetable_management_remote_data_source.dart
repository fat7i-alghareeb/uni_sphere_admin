//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import 'package:uni_sphere_admin/features/timetable_management/data/param/create_schedule.dart';
import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch;
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
      {required int month, required int year, required int majorYear}) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getScheduleByMonth,
          queryParameters: {
            "month": month,
            "year": year,
            "majorYear": majorYear,
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

  Future<DayScheduleModel> addLecture(
      AddLectureParam param, String scheduleId) {
    return throwDioException(
      () async {
        final response = await _dio.post(
          AppUrl.addLecture,
          data: param.toJson(),
          queryParameters: {
            "scheduleId": scheduleId,
          },
        );
        return DayScheduleModel.fromJson(response.data);
      },
    );
  }

  Future<MothScheduleModel> createSchedule(CreateSchedule param) {
    return throwDioException(
      () async {
        final response =
            await _dio.post(AppUrl.createSchedule, data: param.toJson());
        return MothScheduleModel.fromJson(response.data);
      },
    );
  }

  Future<DayScheduleModel> updateSchedule(String id, GlobalPatch patch) {
    return throwDioException(
      () async {
        final response =
            await _dio.patch(AppUrl.updateSchedule(id), data: patch.toJson());
        return DayScheduleModel.fromJson(response.data);
      },
    );
  }
}
