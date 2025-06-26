//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/materials_management/data/datasources/materials_management_remote_data_source.dart';
import '../../../features/materials_management/data/repositories/materials_management_repository_impl.dart';
import '../../../features/materials_management/domain/repositories/materials_management_repository.dart';
import '../../../features/materials_management/domain/usecases/materials_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> materialsManagementInjection() async {
  getIt.registerLazySingleton<MaterialsManagementRemote>(
    () => MaterialsManagementRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<MaterialsManagementRepo>(
    () => MaterialsManagementRepoImp(
      remote: getIt<MaterialsManagementRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<MaterialsManagementUsecase>(
    () => MaterialsManagementUsecase(
      repo: getIt<MaterialsManagementRepo>(),
    ),
  );
}
