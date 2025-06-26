part of 'auth_bloc.dart';

abstract class AuthEvent {}

final class LoginEvent extends AuthEvent {
  LoginParam loginParam;
  LoginEvent({required this.loginParam});
}

final class RegisterEvent extends AuthEvent {
  RegisterParam registerParam;
  RegisterEvent({required this.registerParam});
}

final class CheckOneTimeCodeEvent extends AuthEvent {
  CheckOneTimeParam checkOneTimeParam;
  CheckOneTimeCodeEvent({required this.checkOneTimeParam});
}
