//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../../features/settings/domain/repositories/settings_repository.dart';
import '../../../features/settings/domain/usecases/settings_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> settingsInjection() async {
  getIt.registerLazySingleton<SettingsRemote>(
    () => SettingsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<SettingsRepo>(
    () => SettingsRepoImp(
      remote: getIt<SettingsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<SettingsUsecase>(
    () => SettingsUsecase(
      repo: getIt<SettingsRepo>(),
    ),
  );
}
