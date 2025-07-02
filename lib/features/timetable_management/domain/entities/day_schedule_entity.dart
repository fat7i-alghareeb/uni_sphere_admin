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
}
