import 'timetable_entity.dart';

class DayScheduleEntity {
  final DateTime day;
  final List<TimetableEntity> timetables;

  DayScheduleEntity({
    required this.day,
    required this.timetables,
  });
}