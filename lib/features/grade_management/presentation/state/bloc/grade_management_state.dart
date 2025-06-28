part of 'grade_management_bloc.dart';


class GradeManagementState {
  final Result<bool> result;

  GradeManagementState({
    this.result = const Result.init(),
  });

  GradeManagementState copyWith({
    Result<bool>? result,
  }) {
    return GradeManagementState(
      result: result ?? this.result,
    );
  }
}