//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../repositories/announcements_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementUsecase {
  final AnnouncementsManagementRepo _repo;

  AnnouncementsManagementUsecase({
    required AnnouncementsManagementRepo repo,
  }) : _repo = repo;

}
