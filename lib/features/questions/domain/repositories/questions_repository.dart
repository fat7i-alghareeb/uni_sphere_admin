//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/questions_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class QuestionsRepo {
  QuestionsRepo();

  //* Get All Questions
  Future<Either<String, QuestionsEntity>> getAllQuestions();
}
