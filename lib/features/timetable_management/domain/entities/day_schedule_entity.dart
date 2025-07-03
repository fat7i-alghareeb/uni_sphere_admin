import 'timetable_entity.dart';

class DayScheduleEntity {
  final DateTime day;
  final String id;
  final List<TimetableEntity> timetables;

  DayScheduleEntity({
    required this.day,
    required this.id,
    required this.timetables,
  });

  DayScheduleEntity copyWith({
    DateTime? day,
    String? id,
    List<TimetableEntity>? timetables,
  }) {
    return DayScheduleEntity(
      day: day ?? this.day,
      id: id ?? this.id,
      timetables: timetables ?? this.timetables,
    );
  }
}
