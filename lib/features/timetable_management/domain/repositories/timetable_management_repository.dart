//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/month_schedule_entity.dart' show MonthScheduleEntity;

//!----------------------------  The Class  -------------------------------------!//

abstract class TimetableManagementRepo {
  TimetableManagementRepo();

  //* Get All Timetable
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
      {required int month, required int year});
  Future<Either<String, MonthScheduleEntity>> getAllTimetables();
}
