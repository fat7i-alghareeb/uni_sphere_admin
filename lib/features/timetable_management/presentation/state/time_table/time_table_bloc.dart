import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/shared/request_bodies/globel_patch_body.dart';
import '../../../data/param/add_lecutre.dart' show AddLectureParam;
import '../../../data/param/create_schedule.dart' show CreateSchedule;
import '../../../data/param/update_param.dart' show UpdateScheduleParam;
import '../../../domain/entities/day_schedule_entity.dart'
    show DayScheduleEntity;
import '../../../domain/entities/month_schedule_entity.dart';
import '../../../../../shared/utils/helper/colored_print.dart' show printW;
import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/timetable_management_usecase.dart'
    show TimetableManagementUsecase;
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
    on<AddLectureEvent>(_onAddLecture);
    on<CreateScheduleEvent>(_onCreateSchedule);
    on<UpdateScheduleEvent>(_onUpdateSchedule);
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
          month: event.month.month,
          year: event.month.year,
          majorYear: event.majorYear);

      response.fold(
        (error) {
          // On error, emit loaded state with empty data for fallback UI
          emit(state.copyWith(
            result: Result.loaded(
                data: MonthScheduleEntity(
                    month: event.month, daysTimeTables: [])),
          ));
        },
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
        result: Result.loaded(
            data: MonthScheduleEntity(month: event.month, daysTimeTables: [])),
      ));
    }
  }

  Future<void> _onAddLecture(
      AddLectureEvent event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));

    final response = await _usecase.addLecture(event.param);
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (data) => emit(
        state.copyWith(
          operationResult: Result.loaded(data: true),
          monthsSchedules: _addDayScheduleToState(data, state.monthsSchedules),
        ),
      ),
    );
  }

  Future<void> _onCreateSchedule(
      CreateScheduleEvent event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));

    final response = await _usecase.createSchedule(event.param);
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (data) => emit(
        state.copyWith(
          operationResult: Result.loaded(data: true),
          monthsSchedules: List<MonthScheduleEntity>.from(state.monthsSchedules)
            ..add(data),
        ),
      ),
    );
  }

  Future<void> _onUpdateSchedule(
      UpdateScheduleEvent event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));

    final response = await _usecase.updateSchedule(
        event.id,
        GlobalPatch(
            patches: event.fields
                .map((field) => Patch(
                    path: field.field.name,
                    op: 'replace',
                    from: "",
                    value: field.newValue))
                .toList()));
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (data) => emit(
        state.copyWith(
          operationResult: Result.loaded(data: true),
          monthsSchedules:
              _updateDayScheduleInState(data, state.monthsSchedules),
        ),
      ),
    );
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
          month: event.month.month,
          year: event.month.year,
          majorYear: event.majorYear);

      response.fold(
        (error) {
          // On error, emit loaded state with empty data for fallback UI
          emit(state.copyWith(
            loadMonthResult: Result.loaded(
                data: MonthScheduleEntity(
                    month: event.month, daysTimeTables: [])),
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
        loadMonthResult: Result.loaded(
            data: MonthScheduleEntity(month: event.month, daysTimeTables: [])),
      ));
    }
  }

  bool _hasMonthData(DateTime month) {
    return state.monthsSchedules.any(
      (element) => element.month.month == month.month,
    );
  }

  List<MonthScheduleEntity> _addDayScheduleToState(
      DayScheduleEntity daySchedule,
      List<MonthScheduleEntity> monthsSchedules) {
    final updatedSchedules = monthsSchedules.firstWhere(
      (element) => element.month.month == selectedDateTime.month,
    );

    updatedSchedules.daysTimeTables.add(daySchedule);
    final updatedMonthsSchedules = monthsSchedules
        .map((e) =>
            e.month.month == selectedDateTime.month ? updatedSchedules : e)
        .toList();

    return updatedMonthsSchedules;
  }

  List<MonthScheduleEntity> _updateDayScheduleInState(
      DayScheduleEntity daySchedule,
      List<MonthScheduleEntity> monthsSchedules) {
    final updatedSchedules = monthsSchedules.firstWhere(
      (element) => element.month.month == selectedDateTime.month,
    );

    updatedSchedules.daysTimeTables
        .removeWhere((element) => element.day == daySchedule.day);
    updatedSchedules.daysTimeTables.add(daySchedule);

    final updatedMonthsSchedules = monthsSchedules
        .map((e) =>
            e.month.month == selectedDateTime.month ? updatedSchedules : e)
        .toList();

    return updatedMonthsSchedules;
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
