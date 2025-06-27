import '../../domain/entities/subject_patch_field.dart' show SubjectPatchFields;

class UpdateParam {
  final String newValue;
  final SubjectPatchFields field;

  UpdateParam({required this.newValue, required this.field});
}