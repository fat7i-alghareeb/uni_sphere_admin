//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/announcements_management/data/datasources/announcements_management_remote_data_source.dart';
import '../../../features/announcements_management/data/repositories/announcements_management_repository_impl.dart';
import '../../../features/announcements_management/domain/repositories/announcements_management_repository.dart';
import '../../../features/announcements_management/domain/usecases/announcements_management_usecase.dart';
import '../../../features/announcements_management/domain/usecases/get_admin_announcements_usecase.dart';
import '../../../features/announcements_management/domain/usecases/get_super_admin_announcements_usecase.dart';
import '../../../features/announcements_management/domain/usecases/create_faculty_announcement_usecase.dart';
import '../../../features/announcements_management/domain/usecases/create_major_announcement_usecase.dart';
import '../../../features/announcements_management/presentation/state/bloc/announcements_management_bloc.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> announcementsManagementInjection() async {
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
  getIt.registerLazySingleton<GetAdminAnnouncementsUsecase>(
    () => GetAdminAnnouncementsUsecase(
      getIt<AnnouncementsManagementRepo>(),
    ),
  );
  getIt.registerLazySingleton<GetSuperAdminAnnouncementsUsecase>(
    () => GetSuperAdminAnnouncementsUsecase(
      getIt<AnnouncementsManagementRepo>(),
    ),
  );

  getIt.registerLazySingleton<CreateFacultyAnnouncementUsecase>(
    () => CreateFacultyAnnouncementUsecase(
      repo: getIt<AnnouncementsManagementRepo>(),
    ),
  );

  getIt.registerLazySingleton<CreateMajorAnnouncementUsecase>(
    () => CreateMajorAnnouncementUsecase(
      repo: getIt<AnnouncementsManagementRepo>(),
    ),
  );

  getIt.registerLazySingleton<AnnouncementsManagementBloc>(
    () => AnnouncementsManagementBloc(
      getAdminAnnouncementsUsecase: getIt<GetAdminAnnouncementsUsecase>(),
      getSuperAdminAnnouncementsUsecase:
          getIt<GetSuperAdminAnnouncementsUsecase>(),
      createFacultyAnnouncementUsecase:
          getIt<CreateFacultyAnnouncementUsecase>(),
      createMajorAnnouncementUsecase: getIt<CreateMajorAnnouncementUsecase>(),
    ),
  );
}
