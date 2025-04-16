//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/access_entity.dart';
import '../repositories/access_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AccessUsecase {
  final AccessRepo _repo;

  AccessUsecase({
    required AccessRepo repo,
  }) : _repo = repo;

  //* Get All Access
  Future<Either<String, AccessEntity>> getAllAccess() =>
      _repo.getAllAccess();
}
