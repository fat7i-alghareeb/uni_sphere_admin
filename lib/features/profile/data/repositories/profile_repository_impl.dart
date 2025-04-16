//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/profile_entity.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class ProfileRepoImp implements ProfileRepo {
  final ProfileRemote _remote;

  ProfileRepoImp({
    required ProfileRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, ProfileEntity>> getAllProfile() {
    return throwAppException(
      () async {
        return await _remote.getAllProfile();
      },
    );
  }
}
