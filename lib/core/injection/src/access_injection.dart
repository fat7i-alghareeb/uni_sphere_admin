//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/access/data/datasources/access_remote_data_source.dart';
import '../../../features/access/data/repositories/access_repository_impl.dart';
import '../../../features/access/domain/repositories/access_repository.dart';
import '../../../features/access/domain/usecases/access_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> accessInjection() async {
  getIt.registerLazySingleton<AccessRemote>(
    () => AccessRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<AccessRepo>(
    () => AccessRepoImp(
      remote: getIt<AccessRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<AccessUsecase>(
    () => AccessUsecase(
      repo: getIt<AccessRepo>(),
    ),
  );
}
