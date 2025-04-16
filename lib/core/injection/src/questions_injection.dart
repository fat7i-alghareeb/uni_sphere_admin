//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/questions/data/datasources/questions_remote_data_source.dart';
import '../../../features/questions/data/repositories/questions_repository_impl.dart';
import '../../../features/questions/domain/repositories/questions_repository.dart';
import '../../../features/questions/domain/usecases/questions_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> questionsInjection() async {
  getIt.registerLazySingleton<QuestionsRemote>(
    () => QuestionsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<QuestionsRepo>(
    () => QuestionsRepoImp(
      remote: getIt<QuestionsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<QuestionsUsecase>(
    () => QuestionsUsecase(
      repo: getIt<QuestionsRepo>(),
    ),
  );
}
