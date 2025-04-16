//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/access_entity.dart';
import '../datasources/access_remote_data_source.dart';
import '../../domain/repositories/access_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AccessRepoImp implements AccessRepo {
  final AccessRemote _remote;

  AccessRepoImp({
    required AccessRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, AccessEntity>> getAllAccess() {
    return throwAppException(
      () async {
        return await _remote.getAllAccess();
      },
    );
  }
}
