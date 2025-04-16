//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/timetable_management_entity.dart';
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
  Future<Either<String, TimetableManagementEntity>> getAllTimetableManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllTimetableManagement();
      },
    );
  }
}
