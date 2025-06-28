part of 'time_table_bloc.dart';

abstract class TimeTableEvent {}

final class GetTimeTableEvent extends TimeTableEvent {
  GetTimeTableEvent({required this.month});
  final DateTime month;
}

final class LoadMonthEvent extends TimeTableEvent {
  LoadMonthEvent({required this.month});
  final DateTime month;
}

final class AddLectureEvent extends TimeTableEvent {
  AddLectureEvent({required this.param});
  final AddLectureParam param;
}

final class CreateScheduleEvent extends TimeTableEvent {
  CreateScheduleEvent({required this.param});
  final CreateSchedule param;
}
