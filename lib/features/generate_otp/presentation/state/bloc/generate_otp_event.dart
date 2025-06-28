part of 'generate_otp_bloc.dart';


class GenerateOtpEvent {}

final class AssignOneTimeCodeToStudentEvent extends GenerateOtpEvent {
  final AssignOneTimeCode assignOneTimeCode;

  AssignOneTimeCodeToStudentEvent({required this.assignOneTimeCode});
}

final class AssignOneTimeCodeGeneralEvent extends GenerateOtpEvent {
  final AssignOneTimeCode assignOneTimeCode;

  AssignOneTimeCodeGeneralEvent({required this.assignOneTimeCode});
}
