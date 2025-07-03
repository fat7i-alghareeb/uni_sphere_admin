import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/extensions/string_extension.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/widgets/loading_progress.dart';
import '../../providers/timetable_provider.dart';
import '../../state/time_table/time_table_bloc.dart';
import '../../../domain/entities/month_schedule_entity.dart';
import '../../../domain/entities/timetable_entity.dart';
import 'day_selector.dart';
import 'month_selector.dart';
import 'no_schedule_widgets.dart';
import 'timetable_item.dart';
import 'add_lecture_dialog.dart';
import '../../../data/param/add_lecutre.dart';

class ScheduleContent extends StatelessWidget {
  final int selectedYear;

  const ScheduleContent({
    super.key,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimeTableBloc, TimeTableState>(
      listenWhen: (previous, current) {
        // Only update when the data actually changes
        return current.result.getDataWhenSuccess() !=
            previous.result.getDataWhenSuccess();
      },
      listener: (context, state) {
        final monthData = state.result.getDataWhenSuccess();
        if (monthData != null) {
          final provider = context.read<TimetableProvider>();
          provider.setCurrentDays(monthData.daysTimeTables);
        }
      },
      child: BlocBuilder<TimeTableBloc, TimeTableState>(
        builder: (context, state) {
          final monthData = state.result.getDataWhenSuccess();
          final isLoading = state.result.isLoading();
          final hasData =
              monthData != null && monthData.daysTimeTables.isNotEmpty;

          return Column(
            children: [
              MonthSelector(
                majorYear: selectedYear,
                onMonthChanged: (newMonth, year) {
                  getIt<TimeTableBloc>().add(GetTimeTableEvent(
                    month: DateTime(year, newMonth),
                    majorYear: selectedYear,
                  ));
                  final provider = context.read<TimetableProvider>();
                  provider.setSelectedScheduleDate(null);
                },
              ),
              if (isLoading) const SizedBox(height: 16), // keep layout stable
              if (!hasData && !isLoading)
                Expanded(
                  child: NoSchedulesWidget(
                    isError: false,
                    onRetry: () => _retryCurrentMonth(selectedYear),
                  ),
                ),
              if (hasData && !isLoading) ...[
                DaySelector(
                  days: monthData.daysTimeTables,
                  selectedDayIndex:
                      context.watch<TimetableProvider>().selectedDayIndex,
                  onDaySelected: (index) => context
                      .read<TimetableProvider>()
                      .setSelectedDayIndex(index),
                ),
                _AddLectureButton(
                  selectedDay: context.watch<TimetableProvider>().selectedDay,
                  selectedYear: selectedYear,
                ),
                Expanded(
                  child: _ScheduleContentBody(
                    monthData: monthData,
                    selectedYear: selectedYear,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _retryCurrentMonth(int selectedYear) {
    final now = DateTime.now();
    getIt<TimeTableBloc>().add(GetTimeTableEvent(
      month: DateTime(now.year, now.month),
      majorYear: selectedYear,
    ));
  }
}

class _ScheduleContentBody extends StatelessWidget {
  final MonthScheduleEntity monthData;
  final int selectedYear;

  const _ScheduleContentBody({
    required this.monthData,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TimetableProvider>(
      builder: (context, provider, child) {
        final days = monthData.daysTimeTables;

        if (days.isEmpty) {
          return NoSchedulesWidget(
            isError: false,
            onRetry: null,
          );
        }

        final selectedDay = provider.selectedDay;
        if (selectedDay == null) {
          return NoSchedulesWidget(
            isError: false,
            onRetry: null,
          );
        }

        return BlocListener<TimeTableBloc, TimeTableState>(
          listenWhen: (prev, curr) =>
              prev.operationResult != curr.operationResult,
          listener: (context, state) {
            if (state.operationResult.isLoaded()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${AppStrings.addLecture} - ${AppStrings.success}'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: _ScheduleList(
            selectedDay: selectedDay,
            selectedYear: selectedYear,
          ),
        );
      },
    );
  }
}

class _AddLectureButton extends StatelessWidget {
  final dynamic selectedDay;
  final int selectedYear;

  const _AddLectureButton({
    required this.selectedDay,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(AppStrings.addLecture,
                style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: context.primaryColor,
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _showAddLectureDialog(context, selectedDay),
          ),
        ],
      ),
    );
  }

  void _showAddLectureDialog(BuildContext context, dynamic day) async {
    final param = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddLectureDialog(
        scheduleId: day.id,
        dayName: (day.day.weekday as int).weekdayShort,
        year: selectedYear,
      ),
    );
    if (param != null && param is AddLectureParam && context.mounted) {
      getIt<TimeTableBloc>()
          .add(AddLectureEvent(param: param, scheduleId: day.id));
    }
  }
}

class _ScheduleList extends StatelessWidget {
  final dynamic selectedDay;
  final int selectedYear;

  const _ScheduleList({
    required this.selectedDay,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDay.timetables.isEmpty) {
      return _EmptyDayState(
        selectedDay: selectedDay,
        selectedYear: selectedYear,
      );
    }

    final sortedTimetables = List<TimetableEntity>.from(selectedDay.timetables)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return ListView.builder(
      key: ValueKey<int>(selectedDay.hashCode),
      padding: REdgeInsets.only(
          top: 16,
          bottom: 160,
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding),
      itemCount: sortedTimetables.length,
      itemBuilder: (context, index) {
        return TimetableItem(timetable: sortedTimetables[index]);
      },
    );
  }
}

class _EmptyDayState extends StatelessWidget {
  final dynamic selectedDay;
  final int selectedYear;

  const _EmptyDayState({
    required this.selectedDay,
    required this.selectedYear,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule_outlined,
            size: 64.r,
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          16.verticalSpace,
          Text(
            AppStrings.noScheduleForThisDay,
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.withValues(alpha: 0.7),
            ),
          ),
          24.verticalSpace,
          TextButton.icon(
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(AppStrings.addLecture,
                style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: context.primaryColor,
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => _showAddLectureDialog(context, selectedDay),
          ),
        ],
      ),
    );
  }

  void _showAddLectureDialog(BuildContext context, dynamic day) async {
    final param = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddLectureDialog(
        scheduleId: day.id,
        dayName: day.day.weekday.weekdayShort,
        year: selectedYear,
      ),
    );
    if (param != null && param is AddLectureParam && context.mounted) {
      getIt<TimeTableBloc>()
          .add(AddLectureEvent(param: param, scheduleId: day.id));
    }
  }
}
