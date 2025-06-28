import '../../domain/entities/schedule_patch_field.dart' show SchedulePatchFields;

class UpdateScheduleParam {
  final String newValue;
  final SchedulePatchFields field;

  UpdateScheduleParam({required this.newValue, required this.field});
}
