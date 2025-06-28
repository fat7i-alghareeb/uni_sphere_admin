part of 'time_table_bloc.dart';

class TimeTableState {
  Result<MonthScheduleEntity> result;
  Result<MonthScheduleEntity> loadMonthResult;
  List<MonthScheduleEntity> monthsSchedules;
    final Result<bool> operationResult;

  TimeTableState({
    this.result = const Result.init(),
    this.loadMonthResult = const Result.init(),
    this.monthsSchedules = const [],
    this.operationResult = const Result.loaded(data: true),
  });

  TimeTableState copyWith({
    Result<MonthScheduleEntity>? result,
    Result<MonthScheduleEntity>? loadMonthResult,
    List<MonthScheduleEntity>? monthsSchedules,
    Result<bool>? operationResult,
    Result<DayScheduleEntity>? daySchedule,
  }) {
    return TimeTableState(
      result: result ?? this.result,
      monthsSchedules: monthsSchedules ?? this.monthsSchedules,
      loadMonthResult: loadMonthResult ?? this.loadMonthResult,
      operationResult: operationResult ?? this.operationResult,
    );
  }
}
