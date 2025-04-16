//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/home/data/datasources/home_remote_data_source.dart';
import '../../../features/home/data/repositories/home_repository_impl.dart';
import '../../../features/home/domain/repositories/home_repository.dart';
import '../../../features/home/domain/usecases/home_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> homeInjection() async {
  getIt.registerLazySingleton<HomeRemote>(
    () => HomeRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImp(
      remote: getIt<HomeRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(
      repo: getIt<HomeRepo>(),
    ),
  );
}
