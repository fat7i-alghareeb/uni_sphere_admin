//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/profile_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class ProfileRepo {
  ProfileRepo();

  //* Get All Profile
  Future<Either<String, ProfileEntity>> getAllProfile();
}
