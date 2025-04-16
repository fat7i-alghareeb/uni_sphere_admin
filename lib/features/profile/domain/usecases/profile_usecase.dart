//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class ProfileUsecase {
  final ProfileRepo _repo;

  ProfileUsecase({
    required ProfileRepo repo,
  }) : _repo = repo;

  //* Get All Profile
  Future<Either<String, ProfileEntity>> getAllProfile() =>
      _repo.getAllProfile();
}
