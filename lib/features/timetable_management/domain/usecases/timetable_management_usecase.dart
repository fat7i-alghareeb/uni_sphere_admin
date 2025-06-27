//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/month_schedule_entity.dart' show MonthScheduleEntity;
import '../repositories/timetable_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableManagementUsecase {
  final TimetableManagementRepo _repo;

  TimetableManagementUsecase({
    required TimetableManagementRepo repo,
  }) : _repo = repo;

  //* Get All AnnouncementsManagement
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
          {required int month, required int year}) =>
      _repo.getMonthTimetable(month: month, year: year);
  Future<Either<String, MonthScheduleEntity>> getAllTimetables() =>
      _repo.getAllTimetables();
}
