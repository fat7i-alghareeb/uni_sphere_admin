//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../features/profile/domain/usecases/profile_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> profileInjection() async {
  getIt.registerLazySingleton<ProfileRemote>(
    () => ProfileRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImp(
      remote: getIt<ProfileRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<ProfileUsecase>(
    () => ProfileUsecase(
      repo: getIt<ProfileRepo>(),
    ),
  );
}
