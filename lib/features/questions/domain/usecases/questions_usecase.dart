//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/questions_entity.dart';
import '../repositories/questions_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class QuestionsUsecase {
  final QuestionsRepo _repo;

  QuestionsUsecase({
    required QuestionsRepo repo,
  }) : _repo = repo;

  //* Get All Questions
  Future<Either<String, QuestionsEntity>> getAllQuestions() =>
      _repo.getAllQuestions();
}
