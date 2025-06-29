part of 'info_bloc.dart';

class InfoState {
  final Result<List<Faculty>> faculties;
  final Result<List<Major>> majors;
  final Result<List<Major>> superAdminMajors;

  InfoState({
    this.faculties = const Result.init(),
    this.majors = const Result.init(),
    this.superAdminMajors = const Result.init(),
  });

  InfoState copyWith({
    Result<List<Faculty>>? faculties,
    Result<List<Major>>? majors,
    Result<List<Major>>? superAdminMajors,
  }) {
    return InfoState(
      faculties: faculties ?? this.faculties,
      majors: majors ?? this.majors,
      superAdminMajors: superAdminMajors ?? this.superAdminMajors,
    );
  }
}
