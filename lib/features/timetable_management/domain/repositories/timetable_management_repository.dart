//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/timetable_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class TimetableManagementRepo {
  TimetableManagementRepo();

  //* Get All TimetableManagement
  Future<Either<String, TimetableManagementEntity>> getAllTimetableManagement();
}
