import 'package:fpdart/fpdart.dart';
import '../repositories/announcements_management_repository.dart';
import '../entities/announcement_entity.dart';
import '../../data/params/create_major_announcement_param.dart';

class CreateMajorAnnouncementUsecase {
  final AnnouncementsManagementRepo _repo;

  CreateMajorAnnouncementUsecase({
    required AnnouncementsManagementRepo repo,
  }) : _repo = repo;

  Future<Either<String, AnnouncementEntity>> call(
      CreateMajorAnnouncementParam param) async {
    return await _repo.createMajorAnnouncement(param);
  }
}
