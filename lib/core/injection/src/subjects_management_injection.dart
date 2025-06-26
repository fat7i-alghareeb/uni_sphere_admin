//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/subjects_management/data/datasources/subjects_management_remote_data_source.dart';
import '../../../features/subjects_management/data/repositories/subjects_management_repository_impl.dart';
import '../../../features/subjects_management/domain/repositories/subjects_management_repository.dart';
import '../../../features/subjects_management/domain/usecases/subjects_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> subjectsManagementInjection() async {
  getIt.registerLazySingleton<SubjectsManagementRemote>(
    () => SubjectsManagementRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<SubjectsManagementRepo>(
    () => SubjectsManagementRepoImp(
      remote: getIt<SubjectsManagementRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<SubjectsManagementUsecase>(
    () => SubjectsManagementUsecase(
      repo: getIt<SubjectsManagementRepo>(),
    ),
  );
}
