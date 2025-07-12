//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AnnouncementsManagementRepo {
  AnnouncementsManagementRepo();

  Future<Either<String, List<AnnouncementEntity>>> getAdminAnnouncements(
      {int? year});
  Future<Either<String, List<AnnouncementEntity>>> getSuperAdminAnnouncements();
}
