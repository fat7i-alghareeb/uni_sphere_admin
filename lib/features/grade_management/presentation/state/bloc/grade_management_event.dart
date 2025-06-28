part of 'grade_management_bloc.dart';

sealed class GradeManagementEvent {}

final class AssignGradesToSubjectEvent extends GradeManagementEvent {
  final SubjectGrade subjectGrade;

  AssignGradesToSubjectEvent({required this.subjectGrade});
}