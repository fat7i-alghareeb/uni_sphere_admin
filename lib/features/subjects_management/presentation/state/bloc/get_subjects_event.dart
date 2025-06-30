part of 'get_subjects_bloc.dart';

sealed class GetSubjectsEvent {}

class GetSuperAdminSubjectsEvent extends GetSubjectsEvent {
  final int year;
  final String majorId;

  GetSuperAdminSubjectsEvent({required this.year, required this.majorId});
}

class GetProfessorSubjectsEvent extends GetSubjectsEvent {}

class UpdateSubjectEvent extends GetSubjectsEvent {
  final String id;
  final List<UpdateSubjectParam> fields;

  UpdateSubjectEvent({required this.id, required this.fields});
}

class UploadMaterialEvent extends GetSubjectsEvent {
  final String id;
  final File? file;
  final String? url;

  UploadMaterialEvent(
      {required this.id, required this.file, required this.url});
}
