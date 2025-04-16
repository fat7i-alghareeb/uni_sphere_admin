//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/grade_management_entity.dart';
import '../datasources/grade_management_remote_data_source.dart';
import '../../domain/repositories/grade_management_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradeManagementRepoImp implements GradeManagementRepo {
  final GradeManagementRemote _remote;

  GradeManagementRepoImp({
    required GradeManagementRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, GradeManagementEntity>> getAllGradeManagement() {
    return throwAppException(
      () async {
        return await _remote.getAllGradeManagement();
      },
    );
  }
}
