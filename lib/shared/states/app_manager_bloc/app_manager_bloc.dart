// 🎯 Dart imports:
import 'dart:async';
import 'dart:developer';

//  Package imports:
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:equatable/equatable.dart';
// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repo/auth_repo/auth_repo.dart';

// 🌎 Project imports:

//  Package imports:


part 'app_manager_event.dart';
part 'app_manager_state.dart';

///This bloc use for redirect in go router
class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc(
      {required this.lazyAuthRepository,
      this.doBeforeOpen,
      required this.context})
      : super(const AppManagerState(status: Status.initial)) {
    on<AppManagerEvent>(_handler);
  }

  final BuildContext context;

  /// Wait [getIt] injection before read AuthRepo implementation from service locator
  final AuthRepository Function() lazyAuthRepository;

  /// Do some initiation before close splash and open app
  final FutureOr<void> Function()? doBeforeOpen;

  late final AuthRepository _authRepository;

  late final StreamSubscription<AuthStatus> _authStateStream;

  FutureOr<void> _handler(
      AppManagerEvent event, Emitter<AppManagerState> emit) async {
    if (event is AppMangerUnExpiredApp) {
      emit(state.copyWith(expired: false, checkedUpdate: true));
    }
    if (event is AppMangerExpiredApp) {
      emit(state.copyWith(
          expired: true, isSupported: event.isSupported, checkedUpdate: true));
    }
    if (event is AppManagerStarted) {
      try {
        await doBeforeOpen?.call();
      } catch (e, s) {
        log(e.toString(), stackTrace: s);
      }
      // emit(state.copyWith(choosePassed: getIt<StorageService<SharedStorage>>().getBool(kIsPassedChoosing)));

      _authRepository = lazyAuthRepository();
      _authStateStream = _authRepository.authStatusStream.listen(
        (event) {
          add(AppManageStatusChanged(
              status: event.status, message: event.message));
        },
      );
    } else if (event is AppManageStatusChanged) {
      emit(state.copyWith(status: event.status, message: event.message));
    } else if (event is AppManagerLoggedOut) {
      try {
        await _authRepository.logout();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    _authStateStream.cancel();
    return super.close();
  }
}
