import 'package:fpdart/fpdart.dart';
import '../repositories/announcements_management_repository.dart';
import '../../data/params/create_faculty_announcement_param.dart';

class CreateFacultyAnnouncementUsecase {
  final AnnouncementsManagementRepo _repo;

  CreateFacultyAnnouncementUsecase({
    required AnnouncementsManagementRepo repo,
  }) : _repo = repo;

  Future<Either<String, void>> call(
      CreateFacultyAnnouncementParam param) async {
    return await _repo.createFacultyAnnouncement(param);
  }
}
