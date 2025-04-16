//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/notifications_management_entity.dart';
import '../datasources/notifications_management_remote_data_source.dart';
import '../../domain/repositories/notifications_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsManagementRepoImp implements NotificationsManagementRepo {
  final NotificationsManagementRemote _remote;

  NotificationsManagementRepoImp({
    required NotificationsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, NotificationsManagementEntity>> getAllNotificationsManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllNotificationsManagement();
      },
    );
  }
}
