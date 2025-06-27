//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:uni_sphere_admin/features/timetable_management/data/mappers/schedule_mappers.dart';
import '../../domain/entities/month_schedule_entity.dart'
    show MonthScheduleEntity;
import '../datasources/timetable_management_remote_data_source.dart';
import '../../domain/repositories/timetable_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableManagementRepoImp implements TimetableManagementRepo {
  final TimetableManagementRemote _remote;

  TimetableManagementRepoImp({
    required TimetableManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
      {required int month, required int year}) {
    return throwAppException(
      () async {
        final monthTimetable =
            await _remote.getMonthTimetable(month: month, year: year);
        return monthTimetable.toEntity();
      },
    );
  }

  @override
  Future<Either<String, MonthScheduleEntity>> getAllTimetables() {
    return throwAppException(
      () async {
        final allTimetables = await _remote.getAllTimetables();
        return allTimetables.toEntity();
      },
    );
  }
}
