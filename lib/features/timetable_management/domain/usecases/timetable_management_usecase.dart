//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:uni_sphere_admin/features/timetable_management/domain/entities/day_schedule_entity.dart' show DayScheduleEntity;
import '../../data/param/add_lecutre.dart';
import '../../data/param/create_schedule.dart' show CreateSchedule;
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
  Future<Either<String, DayScheduleEntity>> addLecture(AddLectureParam param) =>
      _repo.addLecture(param);
  Future<Either<String, MonthScheduleEntity>> createSchedule(CreateSchedule param) =>
      _repo.createSchedule(param);
}
