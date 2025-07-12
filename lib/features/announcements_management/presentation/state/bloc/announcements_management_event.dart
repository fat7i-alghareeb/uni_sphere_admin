part of 'announcements_management_bloc.dart';

abstract class AnnouncementsManagementEvent {}

class GetAdminAnnouncementsEvent extends AnnouncementsManagementEvent {
  final int year;
  GetAdminAnnouncementsEvent({required this.year});
}

class GetSuperAdminAnnouncementsEvent extends AnnouncementsManagementEvent {}
