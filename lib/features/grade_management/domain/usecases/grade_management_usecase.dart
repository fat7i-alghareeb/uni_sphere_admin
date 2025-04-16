//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/grade_management_entity.dart';
import '../repositories/grade_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradeManagementUsecase {
  final GradeManagementRepo _repo;

  GradeManagementUsecase({
    required GradeManagementRepo repo,
  }) : _repo = repo;

  //* Get All GradeManagement
  Future<Either<String, GradeManagementEntity>> getAllGradeManagement() =>
      _repo.getAllGradeManagement();
}
