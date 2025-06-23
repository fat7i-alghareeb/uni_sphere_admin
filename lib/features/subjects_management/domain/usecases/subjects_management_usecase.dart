//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/subjects_management_entity.dart';
import '../repositories/subjects_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementUsecase {
  final SubjectsManagementRepo _repo;

  SubjectsManagementUsecase({
    required SubjectsManagementRepo repo,
  }) : _repo = repo;

  //* Get All SubjectsManagement
  Future<Either<String, Subject>> getAllSubjectsManagement() =>
      _repo.getAllSubjectsManagement();
}
