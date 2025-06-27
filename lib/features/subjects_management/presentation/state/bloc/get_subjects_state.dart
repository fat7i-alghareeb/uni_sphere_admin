part of 'get_subjects_bloc.dart';

class SubjectState {
  final Result<FacultySubjects> getSuperAdminSubjectsResult;
  final Result<UniversitySubjects> getProfessorSubjectsResult;
  final Result<Subject> getSubjectByIdResult;

  SubjectState({
    this.getSuperAdminSubjectsResult = const Result.init(),
    this.getProfessorSubjectsResult = const Result.init(),
    this.getSubjectByIdResult = const Result.init(),
  });

  SubjectState copyWith({
    Result<FacultySubjects>? getSuperAdminSubjectsResult,
    Result<UniversitySubjects>? getProfessorSubjectsResult,
    Result<Subject>? getSubjectByIdResult,
  }) =>
      SubjectState(
        getSuperAdminSubjectsResult:
            getSuperAdminSubjectsResult ?? this.getSuperAdminSubjectsResult,
        getProfessorSubjectsResult:
            getProfessorSubjectsResult ?? this.getProfessorSubjectsResult,
        getSubjectByIdResult:
            getSubjectByIdResult ?? this.getSubjectByIdResult,
        );
  }
