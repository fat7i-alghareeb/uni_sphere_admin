//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/subjects_management_entity.dart';
import '../datasources/subjects_management_remote_data_source.dart';
import '../../domain/repositories/subjects_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsManagementRepoImp implements SubjectsManagementRepo {
  final SubjectsManagementRemote _remote;

  SubjectsManagementRepoImp({
    required SubjectsManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, Subject>> getAllSubjectsManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllSubjectsManagement();
      },
    );
  }
}
