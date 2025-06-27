import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/month_schedule_entity.dart';
import '../../../../../shared/utils/helper/colored_print.dart' show printW;
import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/timetable_management_usecase.dart' show TimetableManagementUsecase;
part 'time_table_event.dart';
part 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final TimetableManagementUsecase _usecase;
  static late DateTime selectedDateTime;

  TimeTableBloc({required TimetableManagementUsecase usecase})
      : _usecase = usecase,
        super(TimeTableState()) {
    on<GetTimeTableEvent>(_onGetTimeTable);
    on<LoadMonthEvent>(_onLoadMonth);
  }

  Future<void> _onGetTimeTable(
      GetTimeTableEvent event, Emitter<TimeTableState> emit) async {
    try {
      // Update selected date time immediately
      selectedDateTime = event.month;

      emit(state.copyWith(
        result: const Result.loading(),
        monthsSchedules: [],
      ));

      final response = await _usecase.getMonthTimetable(
          month: event.month.month, year: event.month.year);

      response.fold(
        (error) => emit(state.copyWith(
          result: Result.error(error: error),
        )),
        (data) {
          final updatedSchedules =
              List<MonthScheduleEntity>.from(state.monthsSchedules)..add(data);

          emit(state.copyWith(
            result: Result.loaded(data: data),
            monthsSchedules: updatedSchedules,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        result: Result.error(error: e.toString()),
      ));
    }
  }

  Future<void> _onLoadMonth(
      LoadMonthEvent event, Emitter<TimeTableState> emit) async {
    try {
      // Update selected date time immediately for navigation
      selectedDateTime = event.month;

      // Check if we already have the month's data
      if (_hasMonthData(event.month)) {
        _emitExistingMonthData(event.month, emit);
        return;
      }

      emit(state.copyWith(loadMonthResult: const Result.loading()));

      final response = await _usecase.getMonthTimetable(
          month: event.month.month, year: event.month.year);

      response.fold(
        (error) {
          printW(error);
          emit(state.copyWith(
            loadMonthResult: Result.error(error: error),
          ));
        },
        (data) {
          final updatedSchedules =
              List<MonthScheduleEntity>.from(state.monthsSchedules)..add(data);

          emit(state.copyWith(
            loadMonthResult: Result.loaded(data: data),
            monthsSchedules: updatedSchedules,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        loadMonthResult: Result.error(error: e.toString()),
      ));
    }
  }

  bool _hasMonthData(DateTime month) {
    return state.monthsSchedules.any(
      (element) => element.month.month == month.month,
    );
  }

  void _emitExistingMonthData(DateTime month, Emitter<TimeTableState> emit) {
    final existingData = state.monthsSchedules.firstWhere(
      (element) => element.month.month == month.month,
      orElse: () => MonthScheduleEntity(
        month: month,
        daysTimeTables: [],
      ),
    );

    emit(state.copyWith(
      loadMonthResult: Result.loaded(data: existingData),
    ));
  }

  MonthScheduleEntity get getMonthsSchedulesByDateTime {
    return state.monthsSchedules.firstWhere(
      (element) => element.month.month == selectedDateTime.month,
      orElse: () => MonthScheduleEntity(
        month: selectedDateTime,
        daysTimeTables: [],
      ),
    );
  }
}
