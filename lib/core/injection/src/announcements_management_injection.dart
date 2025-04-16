//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/announcements_management/data/datasources/announcements_management_remote_data_source.dart';
import '../../../features/announcements_management/data/repositories/announcements_management_repository_impl.dart';
import '../../../features/announcements_management/domain/repositories/announcements_management_repository.dart';
import '../../../features/announcements_management/domain/usecases/announcements_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> announcements_managementInjection() async {
  getIt.registerLazySingleton<AnnouncementsManagementRemote>(
    () => AnnouncementsManagementRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<AnnouncementsManagementRepo>(
    () => AnnouncementsManagementRepoImp(
      remote: getIt<AnnouncementsManagementRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<AnnouncementsManagementUsecase>(
    () => AnnouncementsManagementUsecase(
      repo: getIt<AnnouncementsManagementRepo>(),
    ),
  );
}
