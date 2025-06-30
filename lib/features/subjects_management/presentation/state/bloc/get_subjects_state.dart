part of 'get_subjects_bloc.dart';

class SubjectState {
  final Result<SuperAdminSubjects> getSuperAdminSubjectsResult;
  final Result<UniversitySubjects> getProfessorSubjectsResult;
  final Result<bool> operationResult;

  SubjectState({
    this.getSuperAdminSubjectsResult = const Result.init(),
    this.getProfessorSubjectsResult = const Result.init(),
    this.operationResult = const Result.loaded(data: true),
  });

  SubjectState copyWith({
    Result<SuperAdminSubjects>? getSuperAdminSubjectsResult,
    Result<UniversitySubjects>? getProfessorSubjectsResult,
    Result<bool>? operationResult,
  }) =>
      SubjectState(
        getSuperAdminSubjectsResult:
            getSuperAdminSubjectsResult ?? this.getSuperAdminSubjectsResult,
        getProfessorSubjectsResult:
            getProfessorSubjectsResult ?? this.getProfessorSubjectsResult,
        operationResult: operationResult ?? const Result.loaded(data: true),
      );
}
