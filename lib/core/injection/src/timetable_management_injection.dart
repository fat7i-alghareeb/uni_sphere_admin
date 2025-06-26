//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/timetable_management/data/datasources/timetable_management_remote_data_source.dart';
import '../../../features/timetable_management/data/repositories/timetable_management_repository_impl.dart';
import '../../../features/timetable_management/domain/repositories/timetable_management_repository.dart';
import '../../../features/timetable_management/domain/usecases/timetable_management_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> timetableManagementInjection() async {
  getIt.registerLazySingleton<TimetableManagementRemote>(
    () => TimetableManagementRemote(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<TimetableManagementRepo>(
    () => TimetableManagementRepoImp(
      remote: getIt<TimetableManagementRemote>(),
    ),
  );

  getIt.registerLazySingleton<TimetableManagementUsecase>(
    () => TimetableManagementUsecase(
      repo: getIt<TimetableManagementRepo>(),
    ),
  );
}
