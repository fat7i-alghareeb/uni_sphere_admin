//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/questions_entity.dart';
import '../datasources/questions_remote_data_source.dart';
import '../../domain/repositories/questions_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class QuestionsRepoImp implements QuestionsRepo {
  final QuestionsRemote _remote;

  QuestionsRepoImp({
    required QuestionsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, QuestionsEntity>> getAllQuestions() {
    return throwAppException(
      () async {
        return await _remote.getAllQuestions();
      },
    );
  }
}
