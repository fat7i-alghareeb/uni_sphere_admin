import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' show Either;
import '../../../../../core/result_builder/result.dart' show Result;
import '../../../../../shared/entities/role.dart' show Role;
import '../../../data/params/login_param.dart';
import '../../../domain/usecases/access_usecase.dart';
import '../../../../../shared/entities/user.dart';

import '../../../data/params/check_one_time_param.dart' show CheckOneTimeParam;
import '../../../data/params/register_param.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases _useCase;
  static bool isCheckingOneTimeCode = false;
  static Role selectedRole = Role.admin;
  AuthBloc({required AuthUsecases useCase})
      : _useCase = useCase,
        super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<CheckOneTimeCodeEvent>(_checkOneTime);
  }

  _login(LoginEvent event, Emitter emit) async {
    emit(state.copyWith(loginResult: const Result.loading()));
    Either<String, User> response;
    switch (selectedRole) {
      case Role.admin:
        response = await _useCase.loginAdmin(loginParam: event.loginParam);
        break;
      case Role.professor:
        response = await _useCase.loginProfessor(loginParam: event.loginParam);
        break;
      case Role.superadmin:
        response = await _useCase.loginSuperAdmin(loginParam: event.loginParam);
        break;
      case Role.systemcontroller:
        response =
            await _useCase.loginSystemController(loginParam: event.loginParam);
        break;
      case Role.unknown:
        response = await _useCase.loginAdmin(loginParam: event.loginParam);
        break;
    }
    response.fold(
      (l) => emit(
        state.copyWith(
          loginResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          loginResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  _register(RegisterEvent event, Emitter emit) async {
    emit(state.copyWith(registerResult: const Result.loading()));
    Either<String, User> response;
    switch (selectedRole) {
      case Role.admin:
        response = await _useCase.registerAdmin(registerParam: event.registerParam);
        break;
      case Role.professor:
        response = await _useCase.registerProfessor(registerParam: event.registerParam);
        break;
      case Role.superadmin:
        response = await _useCase.registerSuperAdmin(registerParam: event.registerParam);
        break;
      case Role.systemcontroller:
        response = await _useCase.registerSuperAdmin(registerParam: event.registerParam);
        break;
      case Role.unknown:
        response = await _useCase.registerAdmin(registerParam: event.registerParam);
        break;
    } 
    response.fold(
      (l) => emit(
        state.copyWith(
          registerResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          registerResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  _checkOneTime(CheckOneTimeCodeEvent event, Emitter emit) async {
    emit(state.copyWith(checkOneTimeResult: const Result.loading()));
    Either<String, String> response;
      switch (selectedRole) {
      case Role.admin:
        response = await _useCase.checkOneTimeCodeAdmin(checkOneTimeParam: event.checkOneTimeParam);
        break;
      case Role.professor:
        response = await _useCase.checkOneTimeCodeProfessor(checkOneTimeParam: event.checkOneTimeParam);
        break;
        case Role.superadmin:
        response = await _useCase.checkOneTimeCodeSuperAdmin(checkOneTimeParam: event.checkOneTimeParam);
        break;
      case Role.systemcontroller:
        response = await _useCase.checkOneTimeCodeSuperAdmin(checkOneTimeParam: event.checkOneTimeParam);
        break;
      case Role.unknown:
        response = await _useCase.checkOneTimeCodeAdmin(checkOneTimeParam: event.checkOneTimeParam);
        break;
      }
        response.fold(
      (l) => emit(
        state.copyWith(
          checkOneTimeResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          checkOneTimeResult: Result.loaded(data: r),
        ),
      ),
    );
  }
}
