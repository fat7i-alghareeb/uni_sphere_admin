//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class HomeUsecase {
  final HomeRepo _repo;

  HomeUsecase({
    required HomeRepo repo,
  }) : _repo = repo;

  //* Get All Home
  Future<Either<String, HomeEntity>> getAllHome() =>
      _repo.getAllHome();
}
