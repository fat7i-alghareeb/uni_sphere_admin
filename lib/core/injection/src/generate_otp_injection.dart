//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/generate_otp/data/datasources/generate_otp_remote_data_source.dart';
import '../../../features/generate_otp/data/repositories/generate_otp_repository_impl.dart';
import '../../../features/generate_otp/domain/repositories/generate_otp_repository.dart';
import '../../../features/generate_otp/domain/usecases/generate_otp_usecase.dart';
import '../injection.dart';
import '../../../features/generate_otp/presentation/state/bloc/generate_otp_bloc.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> generateOtpInjection() async {
  getIt.registerLazySingleton<GenerateOtpRemote>(
    () => GenerateOtpRemote(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<GenerateOtpRepo>(
    () => GenerateOtpRepoImp(
      remote: getIt<GenerateOtpRemote>(),
    ),
  );

  getIt.registerLazySingleton<GenerateOtpUsecase>(
    () => GenerateOtpUsecase(
      repo: getIt<GenerateOtpRepo>(),
    ),
  );

  getIt.registerLazySingleton<GenerateOtpBloc>(
    () => GenerateOtpBloc(
      usecase: getIt<GenerateOtpUsecase>(),
    ),
  );
}
