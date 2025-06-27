import 'day_schedule_entity.dart';

class MonthScheduleEntity {
  final DateTime month;
  final List<DayScheduleEntity> daysTimeTables;

  MonthScheduleEntity({required this.month, required this.daysTimeTables});
}
