part of 'auth_bloc.dart';

class AuthState {
  Result<User> loginResult;
  Result<User> registerResult;
  Result<String> checkOneTimeResult;

  AuthState({
    this.loginResult = const Result.init(),
    this.registerResult = const Result.init(),
    this.checkOneTimeResult = const Result.init(),
  });

  AuthState copyWith({
    Result<User>? loginResult,
    Result<User>? registerResult,
    Result<String>? checkOneTimeResult,
  }) {
    return AuthState(
      loginResult: loginResult ?? this.loginResult,
      registerResult: registerResult ?? this.registerResult,
      checkOneTimeResult: checkOneTimeResult ?? this.checkOneTimeResult,
    );
  }
}
