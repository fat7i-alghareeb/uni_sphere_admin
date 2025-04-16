//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SettingsUsecase {
  final SettingsRepo _repo;

  SettingsUsecase({
    required SettingsRepo repo,
  }) : _repo = repo;

  //* Get All Settings
  Future<Either<String, SettingsEntity>> getAllSettings() =>
      _repo.getAllSettings();
}
