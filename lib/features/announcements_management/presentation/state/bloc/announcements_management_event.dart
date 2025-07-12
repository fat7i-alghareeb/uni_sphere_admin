part of 'announcements_management_bloc.dart';

abstract class AnnouncementsManagementEvent {}

class GetAdminAnnouncementsEvent extends AnnouncementsManagementEvent {
  final int year;
  GetAdminAnnouncementsEvent({required this.year});
}

class GetSuperAdminAnnouncementsEvent extends AnnouncementsManagementEvent {}

class CreateFacultyAnnouncementEvent extends AnnouncementsManagementEvent {
  final CreateFacultyAnnouncementParam param;
  CreateFacultyAnnouncementEvent({required this.param});
}

class CreateMajorAnnouncementEvent extends AnnouncementsManagementEvent {
  final CreateMajorAnnouncementParam param;
  CreateMajorAnnouncementEvent({required this.param});
}
