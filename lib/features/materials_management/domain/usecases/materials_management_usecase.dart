//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/materials_management_entity.dart';
import '../repositories/materials_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsManagementUsecase {
  final MaterialsManagementRepo _repo;

  MaterialsManagementUsecase({
    required MaterialsManagementRepo repo,
  }) : _repo = repo;

  //* Get All MaterialsManagement
  Future<Either<String, MaterialsManagementEntity>> getAllMaterialsManagement() =>
      _repo.getAllMaterialsManagement();
}
