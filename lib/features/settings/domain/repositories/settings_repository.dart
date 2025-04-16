//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/settings_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SettingsRepo {
  SettingsRepo();

  //* Get All Settings
  Future<Either<String, SettingsEntity>> getAllSettings();
}
