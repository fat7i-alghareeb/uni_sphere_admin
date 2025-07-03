part of 'time_table_bloc.dart';

abstract class TimeTableEvent {}

final class GetTimeTableEvent extends TimeTableEvent {
  GetTimeTableEvent({required this.month, required this.majorYear});
  final DateTime month;
  final int majorYear;
}

final class LoadMonthEvent extends TimeTableEvent {
  LoadMonthEvent({required this.month, required this.majorYear});
  final DateTime month;
  final int majorYear;
}

final class AddLectureEvent extends TimeTableEvent {
  AddLectureEvent({required this.param, required this.scheduleId});
  final AddLectureParam param;
  final String scheduleId;
}

final class CreateScheduleEvent extends TimeTableEvent {
  CreateScheduleEvent({required this.year, required this.scheduleDate});
  final int year;
  final String scheduleDate;
}

final class UpdateScheduleEvent extends TimeTableEvent {
  UpdateScheduleEvent({required this.id, required this.fields});
  final String id;
  final List<UpdateScheduleParam> fields;
}
