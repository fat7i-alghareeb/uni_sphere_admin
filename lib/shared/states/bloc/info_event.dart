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

class GetProfessorsEvent extends InfoEvent {}

class GetUnregisteredStudentsByMajorEvent extends InfoEvent {
  final String studentNumber;
  GetUnregisteredStudentsByMajorEvent({required this.studentNumber});
}

class GetUnregisteredAdminsByFacultyEvent extends InfoEvent {}

class GetUnassignedSubjectsEvent extends InfoEvent {
  final String majorId;
  final int majorYear;
  GetUnassignedSubjectsEvent({required this.majorId, required this.majorYear});
}
