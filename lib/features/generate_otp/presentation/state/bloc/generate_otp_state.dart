part of 'generate_otp_bloc.dart';


class GenerateOtpState {
  final Result<bool> result;

  GenerateOtpState({
    this.result = const Result.init(),
  });

  GenerateOtpState copyWith({
    Result<bool>? result,
  }) {
    return GenerateOtpState(
      result: result ?? this.result,
    );
  }
}