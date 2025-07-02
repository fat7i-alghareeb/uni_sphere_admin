part of 'info_bloc.dart';

class InfoState {
  final Result<List<Faculty>> faculties;
  final Result<List<Major>> majors;
  final Result<List<Major>> superAdminMajors;
  final Result<List<SubjectInfo>> myMajorSubjects;
  InfoState({
    this.faculties = const Result.init(),
    this.majors = const Result.init(),
    this.superAdminMajors = const Result.init(),
    this.myMajorSubjects = const Result.init(),
  });

  InfoState copyWith({
    Result<List<Faculty>>? faculties,
    Result<List<Major>>? majors,
    Result<List<Major>>? superAdminMajors,
    Result<List<SubjectInfo>>? myMajorSubjects,
  }) {
    return InfoState(
      faculties: faculties ?? this.faculties,
      majors: majors ?? this.majors,
      superAdminMajors: superAdminMajors ?? this.superAdminMajors,
      myMajorSubjects: myMajorSubjects ?? this.myMajorSubjects,
    );
  }
}
