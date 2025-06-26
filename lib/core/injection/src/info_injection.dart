import 'package:dio/dio.dart';
import '../injection.dart' show getIt;
import '../../../shared/repo/info_repo.dart';

import '../../../shared/remote/info_remote.dart';
import '../../../shared/states/bloc/info_bloc.dart';

Future<void> infoInjection() async {
  getIt.registerSingleton<InfoRemote>(InfoRemote(
    getIt<Dio>(),
  ));
  getIt.registerSingleton<InfoRepo>(InfoRepo(
    infoRemote: getIt<InfoRemote>(),
  ));

  getIt.registerSingleton<InfoBloc>(InfoBloc(
    infoRepo: getIt<InfoRepo>(),
  ));
}
