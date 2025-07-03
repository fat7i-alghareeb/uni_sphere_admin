import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/shared/request_bodies/globel_patch_body.dart';
import '../../../data/param/add_lecutre.dart' show AddLectureParam;
import '../../../data/param/create_schedule.dart' show CreateSchedule;
import '../../../data/param/update_param.dart' show UpdateScheduleParam;
import '../../../domain/entities/day_schedule_entity.dart'
    show DayScheduleEntity;
import '../../../domain/entities/month_schedule_entity.dart';
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
    on<DeleteLectureEvent>(_onDeleteLecture);
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

    final response = await _usecase.addLecture(event.param, event.scheduleId);
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (data) {
        final updatedMonthsSchedules =
            _addDayScheduleToState(data, state.monthsSchedules);
        // Find the updated month entity for the current month
        final updatedMonth = updatedMonthsSchedules.firstWhere(
          (m) =>
              m.month.month == selectedDateTime.month &&
              m.month.year == selectedDateTime.year,
          orElse: () =>
              MonthScheduleEntity(month: selectedDateTime, daysTimeTables: []),
        );
        emit(
          state.copyWith(
            operationResult: Result.loaded(data: true),
            monthsSchedules: updatedMonthsSchedules,
            result: Result.loaded(data: updatedMonth),
          ),
        );
      },
    );
  }

  Future<void> _onCreateSchedule(
      CreateScheduleEvent event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));

    final createScheduleParam = CreateSchedule(
      year: event.year,
      scheduleDate: event.scheduleDate,
    );
    final response = await _usecase.createSchedule(createScheduleParam);
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (data) {
        // Add the new schedule to monthsSchedules
        final updatedMonthsSchedules =
            List<MonthScheduleEntity>.from(state.monthsSchedules)..add(data);

        // Check if the created schedule is for the current month
        final createdDate = DateTime.parse(event.scheduleDate);
        if (createdDate.month == selectedDateTime.month &&
            createdDate.year == selectedDateTime.year) {
          // Get the current month's data
          final currentMonthData = state.result.getDataWhenSuccess();
          if (currentMonthData != null) {
            // Combine existing days with new days from the returned data
            final existingDays =
                List<DayScheduleEntity>.from(currentMonthData.daysTimeTables);
            final newDays = List<DayScheduleEntity>.from(data.daysTimeTables);

            // Add all new days to existing days list
            for (final newDay in newDays) {
              // Check if the day already exists (to avoid duplicates)
              final existingDayIndex = existingDays
                  .indexWhere((day) => day.day.day == newDay.day.day);
              if (existingDayIndex != -1) {
                // Update existing day
                existingDays[existingDayIndex] = newDay;
              } else {
                // Add new day
                existingDays.add(newDay);
              }
            }

            // Sort all days by date
            existingDays.sort((a, b) => a.day.compareTo(b.day));

            // Create updated month data
            final updatedCurrentMonth = MonthScheduleEntity(
              month: currentMonthData.month,
              daysTimeTables: existingDays,
            );

            emit(state.copyWith(
              operationResult: Result.loaded(data: true),
              monthsSchedules: updatedMonthsSchedules,
              result: Result.loaded(data: updatedCurrentMonth),
            ));
          } else {
            // If no current month data, use the new data
            emit(state.copyWith(
              operationResult: Result.loaded(data: true),
              monthsSchedules: updatedMonthsSchedules,
              result: Result.loaded(data: data),
            ));
          }
        } else {
          // If not for current month, just update monthsSchedules
          emit(state.copyWith(
            operationResult: Result.loaded(data: true),
            monthsSchedules: updatedMonthsSchedules,
          ));
        }
      },
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
    final updatedMonthsSchedules = monthsSchedules.map((monthEntity) {
      if (monthEntity.month.month == selectedDateTime.month) {
        final updatedDays =
            List<DayScheduleEntity>.from(monthEntity.daysTimeTables);
        final dayIndex = updatedDays.indexWhere((d) => d.id == daySchedule.id);
        if (dayIndex != -1) {
          updatedDays[dayIndex] = daySchedule;
        } else {
          updatedDays.add(daySchedule);
        }
        return MonthScheduleEntity(
          month: monthEntity.month,
          daysTimeTables: updatedDays,
        );
      }
      return monthEntity;
    }).toList();
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

  Future<void> _onDeleteLecture(
      DeleteLectureEvent event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));
    final response = await _usecase.deleteLecture(event.lectureId);
    response.fold(
      (error) =>
          emit(state.copyWith(operationResult: Result.error(error: error))),
      (deletedId) {
        // Remove the lecture from the state
        final updatedMonthsSchedules = state.monthsSchedules.map((monthEntity) {
          if (monthEntity.month.month == selectedDateTime.month &&
              monthEntity.month.year == selectedDateTime.year) {
            final updatedDays = monthEntity.daysTimeTables.map((day) {
              final updatedTimetables = day.timetables
                  .where((lecture) => lecture.id != deletedId)
                  .toList();
              return day.copyWith(timetables: updatedTimetables);
            }).toList();
            return MonthScheduleEntity(
              month: monthEntity.month,
              daysTimeTables: updatedDays,
            );
          }
          return monthEntity;
        }).toList();
        // Update the result for the current month
        final updatedMonth = updatedMonthsSchedules.firstWhere(
          (m) =>
              m.month.month == selectedDateTime.month &&
              m.month.year == selectedDateTime.year,
          orElse: () =>
              MonthScheduleEntity(month: selectedDateTime, daysTimeTables: []),
        );
        emit(state.copyWith(
          operationResult: Result.loaded(data: true),
          monthsSchedules: updatedMonthsSchedules,
          result: Result.loaded(data: updatedMonth),
        ));
      },
    );
  }
}
