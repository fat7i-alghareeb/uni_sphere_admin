//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/announcements_management_entity.dart';
import '../datasources/announcements_management_remote_data_source.dart';
import '../../domain/repositories/announcements_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsManagementRepoImp implements AnnouncementsManagementRepo {
  final AnnouncementsManagementRemote _remote;

  AnnouncementsManagementRepoImp({
    required AnnouncementsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, AnnouncementsManagementEntity>> getAllAnnouncementsManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllAnnouncementsManagement();
      },
    );
  }
}
