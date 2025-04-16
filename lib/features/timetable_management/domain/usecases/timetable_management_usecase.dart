//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/timetable_management_entity.dart';
import '../repositories/timetable_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableManagementUsecase {
  final TimetableManagementRepo _repo;

  TimetableManagementUsecase({
    required TimetableManagementRepo repo,
  }) : _repo = repo;

  //* Get All TimetableManagement
  Future<Either<String, TimetableManagementEntity>> getAllTimetableManagement() =>
      _repo.getAllTimetableManagement();
}
