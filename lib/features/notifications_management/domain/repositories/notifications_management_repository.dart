//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/notifications_management_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class NotificationsManagementRepo {
  NotificationsManagementRepo();

  //* Get All NotificationsManagement
  Future<Either<String, NotificationsManagementEntity>> getAllNotificationsManagement();
}
