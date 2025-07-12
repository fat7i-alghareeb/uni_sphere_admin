import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/entities/announcement_entity.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/usecases/get_admin_announcements_usecase.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/usecases/get_super_admin_announcements_usecase.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/usecases/create_faculty_announcement_usecase.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/usecases/create_major_announcement_usecase.dart';
import 'package:uni_sphere_admin/features/announcements_management/data/params/create_faculty_announcement_param.dart';
import 'package:uni_sphere_admin/features/announcements_management/data/params/create_major_announcement_param.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';

part 'announcements_management_event.dart';
part 'announcements_management_state.dart';

class AnnouncementsManagementBloc
    extends Bloc<AnnouncementsManagementEvent, AnnouncementsManagementState> {
  final GetAdminAnnouncementsUsecase _getAdminAnnouncementsUsecase;
  final GetSuperAdminAnnouncementsUsecase _getSuperAdminAnnouncementsUsecase;
  final CreateFacultyAnnouncementUsecase _createFacultyAnnouncementUsecase;
  final CreateMajorAnnouncementUsecase _createMajorAnnouncementUsecase;

  AnnouncementsManagementBloc({
    required GetAdminAnnouncementsUsecase getAdminAnnouncementsUsecase,
    required GetSuperAdminAnnouncementsUsecase
        getSuperAdminAnnouncementsUsecase,
    required CreateFacultyAnnouncementUsecase createFacultyAnnouncementUsecase,
    required CreateMajorAnnouncementUsecase createMajorAnnouncementUsecase,
  })  : _getAdminAnnouncementsUsecase = getAdminAnnouncementsUsecase,
        _getSuperAdminAnnouncementsUsecase = getSuperAdminAnnouncementsUsecase,
        _createFacultyAnnouncementUsecase = createFacultyAnnouncementUsecase,
        _createMajorAnnouncementUsecase = createMajorAnnouncementUsecase,
        super(const AnnouncementsManagementState()) {
    on<GetAdminAnnouncementsEvent>(_onGetAdminAnnouncements);
    on<GetSuperAdminAnnouncementsEvent>(_onGetSuperAdminAnnouncements);
    on<CreateFacultyAnnouncementEvent>(_onCreateFacultyAnnouncement);
    on<CreateMajorAnnouncementEvent>(_onCreateMajorAnnouncement);
  }

  Future<void> _onGetAdminAnnouncements(
    GetAdminAnnouncementsEvent event,
    Emitter<AnnouncementsManagementState> emit,
  ) async {
    debugPrint('🔍 Bloc: Getting Admin announcements for year: ${event.year}');
    emit(state.copyWith(adminAnnouncementsResult: const Result.loading()));

    final result = await _getAdminAnnouncementsUsecase(event.year);
    debugPrint('🔍 Bloc: Admin announcements result: $result');

    result.fold(
      (error) {
        debugPrint('🔍 Bloc: Admin announcements error: $error');
        emit(state.copyWith(
          adminAnnouncementsResult: Result.error(error: error),
        ));
      },
      (announcements) {
        debugPrint(
            '🔍 Bloc: Admin announcements success: ${announcements.length} items');
        emit(state.copyWith(
          adminAnnouncementsResult: Result.loaded(data: announcements),
        ));
      },
    );
  }

  Future<void> _onGetSuperAdminAnnouncements(
    GetSuperAdminAnnouncementsEvent event,
    Emitter<AnnouncementsManagementState> emit,
  ) async {
    debugPrint('🔍 Bloc: Getting SuperAdmin announcements');
    emit(state.copyWith(superAdminAnnouncementsResult: const Result.loading()));

    final result = await _getSuperAdminAnnouncementsUsecase();
    debugPrint('🔍 Bloc: SuperAdmin announcements result: $result');

    result.fold(
      (error) {
        debugPrint('🔍 Bloc: SuperAdmin announcements error: $error');
        emit(state.copyWith(
          superAdminAnnouncementsResult: Result.error(error: error),
        ));
      },
      (announcements) {
        debugPrint(
            '🔍 Bloc: SuperAdmin announcements success: ${announcements.length} items');
        emit(state.copyWith(
          superAdminAnnouncementsResult: Result.loaded(data: announcements),
        ));
      },
    );
  }

  Future<void> _onCreateFacultyAnnouncement(
    CreateFacultyAnnouncementEvent event,
    Emitter<AnnouncementsManagementState> emit,
  ) async {
    debugPrint('🔍 Bloc: Creating faculty announcement');
    emit(state.copyWith(createAnnouncementResult: const Result.loading()));

    final result = await _createFacultyAnnouncementUsecase(event.param);
    debugPrint('🔍 Bloc: Create faculty announcement result: $result');

    result.fold(
      (error) {
        debugPrint('🔍 Bloc: Create faculty announcement error: $error');
        emit(state.copyWith(
          createAnnouncementResult: Result.error(error: error),
        ));
      },
      (createdAnnouncement) {
        debugPrint(
            '🔍 Bloc: Create faculty announcement success: ${createdAnnouncement.id}');

        // Add the new announcement to the existing super admin announcements list
        final currentSuperAdminAnnouncements =
            state.superAdminAnnouncementsResult.getDataWhenSuccess() ?? [];
        final updatedAnnouncements = [
          createdAnnouncement,
          ...currentSuperAdminAnnouncements
        ];

        emit(state.copyWith(
          createAnnouncementResult: Result.loaded(data: true),
          superAdminAnnouncementsResult:
              Result.loaded(data: updatedAnnouncements),
        ));
      },
    );
  }

  Future<void> _onCreateMajorAnnouncement(
    CreateMajorAnnouncementEvent event,
    Emitter<AnnouncementsManagementState> emit,
  ) async {
    debugPrint('🔍 Bloc: Creating major announcement');
    emit(state.copyWith(createAnnouncementResult: const Result.loading()));

    final result = await _createMajorAnnouncementUsecase(event.param);
    debugPrint('🔍 Bloc: Create major announcement result: $result');

    result.fold(
      (error) {
        debugPrint('🔍 Bloc: Create major announcement error: $error');
        emit(state.copyWith(
          createAnnouncementResult: Result.error(error: error),
        ));
      },
      (createdAnnouncement) {
        debugPrint(
            '🔍 Bloc: Create major announcement success: ${createdAnnouncement.id}');

        // Add the new announcement to the existing admin announcements list
        final currentAdminAnnouncements =
            state.adminAnnouncementsResult.getDataWhenSuccess() ?? [];
        final updatedAnnouncements = [
          createdAnnouncement,
          ...currentAdminAnnouncements
        ];

        emit(state.copyWith(
          createAnnouncementResult: Result.loaded(data: true),
          adminAnnouncementsResult: Result.loaded(data: updatedAnnouncements),
        ));
      },
    );
  }
}
