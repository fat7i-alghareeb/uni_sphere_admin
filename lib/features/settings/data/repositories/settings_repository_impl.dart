//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/settings_entity.dart';
import '../datasources/settings_remote_data_source.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SettingsRepoImp implements SettingsRepo {
  final SettingsRemote _remote;

  SettingsRepoImp({
    required SettingsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, SettingsEntity>> getAllSettings() {
    return throwAppException(
      () async {
        return await _remote.getAllSettings();
      },
    );
  }
}
