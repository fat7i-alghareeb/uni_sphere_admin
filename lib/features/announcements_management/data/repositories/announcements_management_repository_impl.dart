//!----------------------------  Imports  -------------------------------------!//

import '../datasources/announcements_management_remote_data_source.dart';
import '../../domain/repositories/announcements_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementRepoImp implements AnnouncementsManagementRepo {
  final AnnouncementsManagementRemote _remote;

  AnnouncementsManagementRepoImp({
    required AnnouncementsManagementRemote remote,
  }) : _remote = remote;


}
