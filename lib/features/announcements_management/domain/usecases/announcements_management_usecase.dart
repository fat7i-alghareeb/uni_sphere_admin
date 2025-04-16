//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcements_management_entity.dart';
import '../repositories/announcements_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementUsecase {
  final AnnouncementsManagementRepo _repo;

  AnnouncementsManagementUsecase({
    required AnnouncementsManagementRepo repo,
  }) : _repo = repo;

  //* Get All AnnouncementsManagement
  Future<Either<String, AnnouncementsManagementEntity>> getAllAnnouncementsManagement() =>
      _repo.getAllAnnouncementsManagement();
}
