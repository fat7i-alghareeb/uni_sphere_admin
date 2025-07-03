import '../../../../shared/extensions/date_time_extension.dart';
import '../../domain/entities/day_schedule_entity.dart';
import '../../domain/entities/month_schedule_entity.dart'
    show MonthScheduleEntity;
import '../../domain/entities/timetable_entity.dart' show TimetableEntity;
import '../models/day_schedule_model.dart' show DayScheduleModel;
import '../models/item_model.dart' show ItemModel;
import '../models/moth_schedule_model.dart' show MothScheduleModel;

extension MothScheduleMapper on MothScheduleModel {
  MonthScheduleEntity toEntity() {
    // Include all days, even those with empty schedules
    final allDays = days.map((day) => day.toEntity()).toList();

    return MonthScheduleEntity(
      month: month.toDate() ?? DateTime.now(),
      daysTimeTables: allDays,
    );
  }
}

extension DayScheduleMapper on DayScheduleModel {
  DayScheduleEntity toEntity() {
    return DayScheduleEntity(
      day: day.toDate() ?? DateTime.now(),
      id: id,
      timetables: items.map((item) => item.toEntity()).toList(),
    );
  }
}

extension ItemMapper on ItemModel {
  TimetableEntity toEntity() {
    return TimetableEntity(
      id: id,
      subjectName: subjectName,
      lecturerName: lectureName,
      lectureHall: lectureHall,
      startTime: startTime.toTime() ?? DateTime.now(),
      endTime: endTime.toTime() ?? DateTime.now(),
    );
  }
}
