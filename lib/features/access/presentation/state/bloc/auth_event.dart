part of 'auth_bloc.dart';

abstract class AuthEvent {}

final class LoginEvent extends AuthEvent {
  LoginParam loginParam;
  Role role;
  LoginEvent({required this.loginParam, required this.role});
}

final class RegisterEvent extends AuthEvent {
  RegisterParam registerParam;
    Role role;
  RegisterEvent({required this.registerParam, required this.role});
}

final class CheckOneTimeCodeEvent extends AuthEvent {
  CheckOneTimeParam checkOneTimeParam;
  Role role;
  CheckOneTimeCodeEvent({required this.checkOneTimeParam, required this.role});
}
