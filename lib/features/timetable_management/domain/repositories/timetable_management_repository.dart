//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch;
import '../../data/param/add_lecutre.dart' show AddLectureParam;
import '../../data/param/create_schedule.dart';
import '../entities/day_schedule_entity.dart' show DayScheduleEntity;
import '../entities/month_schedule_entity.dart' show MonthScheduleEntity;

//!----------------------------  The Class  -------------------------------------!//

abstract class TimetableManagementRepo {
  TimetableManagementRepo();

  //* Get All Timetable
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
      {required int month, required int year, required int majorYear});
  Future<Either<String, MonthScheduleEntity>> getAllTimetables();
  Future<Either<String, DayScheduleEntity>> addLecture(
      AddLectureParam param, String scheduleId);
  Future<Either<String, MonthScheduleEntity>> createSchedule(
      CreateSchedule param);
  Future<Either<String, DayScheduleEntity>> updateSchedule(
      String id, GlobalPatch patch);
  Future<Either<String, String>> deleteLecture(String id);
}
