//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/materials_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class MaterialsManagementRepo {
  MaterialsManagementRepo();

  //* Get All MaterialsManagement
  Future<Either<String, MaterialsManagementEntity>> getAllMaterialsManagement();
}
