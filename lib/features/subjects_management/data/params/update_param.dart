import '../../domain/entities/subject_patch_field.dart' show SubjectPatchFields;

class UpdateSubjectParam {
  final dynamic newValue;
  final SubjectPatchFields field;

  UpdateSubjectParam({required this.newValue, required this.field});
}
