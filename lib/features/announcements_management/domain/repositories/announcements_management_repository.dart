//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcements_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AnnouncementsManagementRepo {
  AnnouncementsManagementRepo();

  //* Get All AnnouncementsManagement
  Future<Either<String, AnnouncementsManagementEntity>> getAllAnnouncementsManagement();
}
