//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';
import '../repositories/announcements_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementUsecase {
  final AnnouncementsManagementRepo _repo;

  AnnouncementsManagementUsecase({
    required AnnouncementsManagementRepo repo,
  }) : _repo = repo;

  Future<Either<String, List<AnnouncementEntity>>> getAdminAnnouncements(
          {int? year}) =>
      _repo.getAdminAnnouncements(year: year);

  Future<Either<String, List<AnnouncementEntity>>>
      getSuperAdminAnnouncements() => _repo.getSuperAdminAnnouncements();
}
