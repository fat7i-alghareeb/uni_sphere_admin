import 'day_schedule_model.dart' show DayScheduleModel;

class MothScheduleModel {
  final String month;
  final List<DayScheduleModel> days;

  MothScheduleModel({required this.month, required this.days});

  factory MothScheduleModel.fromJson(Map<String, dynamic> json) {
    return MothScheduleModel(
      month: json['month'],
      days: (json['days'] as List<dynamic>)
          .map((day) => DayScheduleModel.fromJson(day as Map<String, dynamic>))
          .toList(),
    );
  }
}
