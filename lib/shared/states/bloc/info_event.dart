part of 'info_bloc.dart';

abstract class InfoEvent {}

class GetFacultiesEvent extends InfoEvent {}

class GetMajorsEvent extends InfoEvent {
  final String facultyId;
  GetMajorsEvent({required this.facultyId});
}

class GetSuperAdminMajorsEvent extends InfoEvent {}

class GetMyMajorSubjectsEvent extends InfoEvent {
  final int year;
  GetMyMajorSubjectsEvent({required this.year});
}

class GetStudentForSubjectEvent extends InfoEvent {
  final String subjectId;
  GetStudentForSubjectEvent({required this.subjectId});
}