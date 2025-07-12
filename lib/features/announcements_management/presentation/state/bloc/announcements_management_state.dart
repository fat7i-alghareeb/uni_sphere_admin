part of 'announcements_management_bloc.dart';

class AnnouncementsManagementState {
  final Result<List<AnnouncementEntity>> adminAnnouncementsResult;
  final Result<List<AnnouncementEntity>> superAdminAnnouncementsResult;

  const AnnouncementsManagementState({
    this.adminAnnouncementsResult = const Result.init(),
    this.superAdminAnnouncementsResult = const Result.init(),
  });

  AnnouncementsManagementState copyWith({
    Result<List<AnnouncementEntity>>? adminAnnouncementsResult,
    Result<List<AnnouncementEntity>>? superAdminAnnouncementsResult,
  }) {
    return AnnouncementsManagementState(
      adminAnnouncementsResult:
          adminAnnouncementsResult ?? this.adminAnnouncementsResult,
      superAdminAnnouncementsResult:
          superAdminAnnouncementsResult ?? this.superAdminAnnouncementsResult,
    );
  }
}
