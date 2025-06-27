part of 'get_subjects_bloc.dart';


sealed class GetSubjectsEvent {}

class GetSuperAdminSubjectsEvent extends GetSubjectsEvent {
  final int year;
  final String majorId;

  GetSuperAdminSubjectsEvent({required this.year, required this.majorId});
}

class GetProfessorSubjectsEvent extends GetSubjectsEvent {}

class GetSubjectByIdEvent extends GetSubjectsEvent {
  final String id;
  final Role role;

  GetSubjectByIdEvent({required this.id, required this.role});
}

class UpdateSubjectEvent extends GetSubjectsEvent {
  final String id;
  final List<UpdateParam> fields;

  UpdateSubjectEvent({required this.id, required this.fields});
}

class UploadMaterialEvent extends GetSubjectsEvent {
  final String id;
  final File file;

  UploadMaterialEvent({required this.id, required this.file});
}