//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/notifications_management_entity.dart';
import '../repositories/notifications_management_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsManagementUsecase {
  final NotificationsManagementRepo _repo;

  NotificationsManagementUsecase({
    required NotificationsManagementRepo repo,
  }) : _repo = repo;

  //* Get All NotificationsManagement
  Future<Either<String, NotificationsManagementEntity>> getAllNotificationsManagement() =>
      _repo.getAllNotificationsManagement();
}
