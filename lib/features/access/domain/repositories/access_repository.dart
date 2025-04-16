//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/access_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AccessRepo {
  AccessRepo();

  //* Get All Access
  Future<Either<String, AccessEntity>> getAllAccess();
}
