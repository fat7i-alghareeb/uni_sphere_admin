//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/notifications_management/data/datasources/notifications_management_remote_data_source.dart';
import '../../../features/notifications_management/data/repositories/notifications_management_repository_impl.dart';
import '../../../features/notifications_management/domain/repositories/notifications_management_repository.dart';
import '../../../features/notifications_management/domain/usecases/notifications_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> notifications_managementInjection() async {
  getIt.registerLazySingleton<NotificationsManagementRemote>(
    () => NotificationsManagementRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<NotificationsManagementRepo>(
    () => NotificationsManagementRepoImp(
      remote: getIt<NotificationsManagementRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<NotificationsManagementUsecase>(
    () => NotificationsManagementUsecase(
      repo: getIt<NotificationsManagementRepo>(),
    ),
  );
}
