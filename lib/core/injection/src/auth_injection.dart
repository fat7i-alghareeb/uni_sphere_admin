// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:

import '../../../shared/utils/storage_service/storage_service.dart';
import '../../auth_data_source/local/auth_local.dart';
import '../../auth_data_source/local/reactive_token_storage.dart';
import '../../auth_data_source/remote/auth_remote.dart';
import '../../repo/auth_repo/auth_repo.dart';
import '../../repo/auth_repo/repo_imp.dart';
import '../injection.dart';

Future<void> authInjection() async {
  getIt.registerSingleton<AuthLocal>(
      AuthLocal(local: getIt<StorageService<SharedStorage>>()));

  getIt.registerSingleton<AuthRemote>(AuthRemote(getIt<Dio>()));

  getIt.registerSingleton<AuthRepository>(AuthRepoImp(
    remote: getIt<AuthRemote>(),
    reactiveTokenStorage: getIt<ReactiveTokenStorage>(),
    storageService: getIt<AuthLocal>(),
  ));

  // getIt.registerSingleton<AuthFacade>(
  //   AuthFacade(
  //     remote: getIt<AuthRepository>(),
  //   ),
  // );

  // getIt.registerSingleton<AuthBloc>(
  //   AuthBloc(
  //     facade: getIt<AuthFacade>(),
  //   ),
  // );
}
