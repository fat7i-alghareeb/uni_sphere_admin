part of 'get_subjects_bloc.dart';

class SubjectState {
  final Result<FacultySubjects> getSuperAdminSubjectsResult;
  final Result<UniversitySubjects> getProfessorSubjectsResult;
  final Result<Subject> getSubjectByIdResult;
  final Result<bool> operationResult;

  SubjectState({
    this.getSuperAdminSubjectsResult = const Result.init(),
    this.getProfessorSubjectsResult = const Result.init(),
    this.getSubjectByIdResult = const Result.init(),
    this.operationResult = const Result.loaded(data: true),
  });

  SubjectState copyWith({
    Result<FacultySubjects>? getSuperAdminSubjectsResult,
    Result<UniversitySubjects>? getProfessorSubjectsResult,
    Result<Subject>? getSubjectByIdResult,
    Result<bool>? operationResult,
  }) =>
      SubjectState(
        getSuperAdminSubjectsResult:
            getSuperAdminSubjectsResult ?? this.getSuperAdminSubjectsResult,
        getProfessorSubjectsResult:
            getProfessorSubjectsResult ?? this.getProfessorSubjectsResult,
        getSubjectByIdResult: getSubjectByIdResult ?? this.getSubjectByIdResult,
        operationResult: operationResult ?? const Result.loaded(data: true),
      );
}
