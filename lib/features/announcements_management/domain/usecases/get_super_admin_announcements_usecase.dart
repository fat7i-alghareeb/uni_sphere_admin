import 'package:fpdart/fpdart.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/entities/announcement_entity.dart';
import 'package:uni_sphere_admin/features/announcements_management/domain/repositories/announcements_management_repository.dart';

class GetSuperAdminAnnouncementsUsecase {
  final AnnouncementsManagementRepo _repository;

  GetSuperAdminAnnouncementsUsecase(this._repository);

  Future<Either<String, List<AnnouncementEntity>>> call() {
    return _repository.getSuperAdminAnnouncements();
  }
}
