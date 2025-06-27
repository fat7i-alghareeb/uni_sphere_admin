part of 'time_table_bloc.dart';

class TimeTableState {
  Result<MonthScheduleEntity> result;
  Result<MonthScheduleEntity> loadMonthResult;
  List<MonthScheduleEntity> monthsSchedules;
  TimeTableState({
    this.result = const Result.init(),
    this.loadMonthResult = const Result.init(),
    this.monthsSchedules = const [],
  });

  TimeTableState copyWith({
    Result<MonthScheduleEntity>? result,
    Result<MonthScheduleEntity>? loadMonthResult,
    List<MonthScheduleEntity>? monthsSchedules,
  }) {
    return TimeTableState(
      result: result ?? this.result,
      monthsSchedules: monthsSchedules ?? this.monthsSchedules,
      loadMonthResult: loadMonthResult ?? this.loadMonthResult,
    );
  }
}
