//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/grade_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class GradeManagementRepo {
  GradeManagementRepo();

  //* Get All GradeManagement
  Future<Either<String, Grade>> getAllGradeManagement();
}
