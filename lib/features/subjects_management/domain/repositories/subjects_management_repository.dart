//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/subjects_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsManagementRepo {
  SubjectsManagementRepo();

  //* Get All SubjectsManagement
  Future<Either<String, Subject>> getAllSubjectsManagement();
}
