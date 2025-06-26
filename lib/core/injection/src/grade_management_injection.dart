//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/grade_management/data/datasources/grade_management_remote_data_source.dart';
import '../../../features/grade_management/data/repositories/grade_management_repository_impl.dart';
import '../../../features/grade_management/domain/repositories/grade_management_repository.dart';
import '../../../features/grade_management/domain/usecases/grade_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> gradeManagementInjection() async {
  getIt.registerLazySingleton<GradeManagementRemote>(
    () => GradeManagementRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<GradeManagementRepo>(
    () => GradeManagementRepoImp(
      remote: getIt<GradeManagementRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<GradeManagementUsecase>(
    () => GradeManagementUsecase(
      repo: getIt<GradeManagementRepo>(),
    ),
  );
}
