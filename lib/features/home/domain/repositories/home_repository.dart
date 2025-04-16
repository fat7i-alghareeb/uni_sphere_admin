//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/home_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class HomeRepo {
  HomeRepo();

  //* Get All Home
  Future<Either<String, HomeEntity>> getAllHome();
}
