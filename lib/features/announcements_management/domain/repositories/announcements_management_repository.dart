//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';
import '../../data/params/create_faculty_announcement_param.dart';
import '../../data/params/create_major_announcement_param.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AnnouncementsManagementRepo {
  AnnouncementsManagementRepo();

  Future<Either<String, List<AnnouncementEntity>>> getAdminAnnouncements(
      {int? year});
  Future<Either<String, List<AnnouncementEntity>>> getSuperAdminAnnouncements();
  Future<Either<String, AnnouncementEntity>> createFacultyAnnouncement(
      CreateFacultyAnnouncementParam param);
  Future<Either<String, AnnouncementEntity>> createMajorAnnouncement(
      CreateMajorAnnouncementParam param);
}
