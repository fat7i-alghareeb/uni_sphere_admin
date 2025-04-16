//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/materials_management_entity.dart';
import '../datasources/materials_management_remote_data_source.dart';
import '../../domain/repositories/materials_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsManagementRepoImp implements MaterialsManagementRepo {
  final MaterialsManagementRemote _remote;

  MaterialsManagementRepoImp({
    required MaterialsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, MaterialsManagementEntity>> getAllMaterialsManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllMaterialsManagement();
      },
    );
  }
}
