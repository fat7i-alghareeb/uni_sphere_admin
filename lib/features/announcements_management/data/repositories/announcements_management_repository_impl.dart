//!----------------------------  Imports  -------------------------------------!//

import 'package:fpdart/fpdart.dart';
import '../../../../shared/services/exception/error_handler.dart';
import '../datasources/announcements_management_remote_data_source.dart';
import '../../domain/entities/announcement_entity.dart';
import '../../domain/repositories/announcements_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementRepoImp implements AnnouncementsManagementRepo {
  final AnnouncementsManagementRemote _remote;

  AnnouncementsManagementRepoImp({
    required AnnouncementsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, List<AnnouncementEntity>>> getAdminAnnouncements(
      {int? year}) async {
    return await throwAppException(
      () async {
        return await _remote.getAdminAnnouncements(year: year);
      },
    );
  }

  @override
  Future<Either<String, List<AnnouncementEntity>>>
      getSuperAdminAnnouncements() async {
    return await throwAppException(
      () async {
        return await _remote.getSuperAdminAnnouncements();
      },
    );
  }
}
