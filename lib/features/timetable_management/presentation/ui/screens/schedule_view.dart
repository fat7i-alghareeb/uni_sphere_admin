import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/entities/user.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/widgets/loading_progress.dart';

import '../../../presentation/state/time_table/time_table_bloc.dart';
import '../../../domain/entities/month_schedule_entity.dart';
import '../../../domain/entities/day_schedule_entity.dart';
import '../../../../../shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import '../widgets/day_selector.dart' show DaySelector;
import '../widgets/month_selector.dart' show MonthSelector;
import '../widgets/no_schedule_widgets.dart' show NoSchedulesWidget;
import '../widgets/timetable_item.dart' show TimetableItem;
import '../widgets/add_lecture_dialog.dart' show AddLectureDialog;
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/extensions/string_extension.dart';
import 'package:uni_sphere_admin/features/timetable_management/data/param/add_lecutre.dart';
import '../../../domain/entities/timetable_entity.dart';

class ScheduleView extends StatefulWidget {
  final User user;
  const ScheduleView({super.key, required this.user});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  int? selectedYear;
  late int numberOfMajorYears;
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    numberOfMajorYears = widget.user.numberOfMajorYears ?? 4;
  }

  void _onYearSelected(String? name, String? id) {
    if (id != null) {
      setState(() {
        selectedYear = int.tryParse(id);
        isInit = true;
      });
      // Use the selected major year as majorYear, and current year as year
      final now = DateTime.now();
      getIt<TimeTableBloc>().add(GetTimeTableEvent(
        month: DateTime(now.year, now.month),
        majorYear: selectedYear!,
      ));
    }
  }

  void _showAddLectureDialog(
      BuildContext context, DayScheduleEntity day) async {
    final param = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddLectureDialog(
        scheduleId: day.id,
        dayName: day.day.weekday.weekdayShort,
      ),
    );
    if (param != null && param is AddLectureParam && context.mounted) {
      getIt<TimeTableBloc>()
          .add(AddLectureEvent(param: param, scheduleId: day.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppConstants.userRole != Role.admin) {
      return Center(child: Text(AppStrings.notAuthorized));
    }
    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.selectMajorYear,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (selectedYear != null)
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
                  onPressed: () {
                    // Open dialog for the first available day with schedules, or fallback to first day
                    final state = getIt<TimeTableBloc>().state;
                    final monthData = state.result.getDataWhenSuccess();
                    final days = monthData?.daysTimeTables ?? [];
                    final daysWithSchedules =
                        days.where((day) => day.timetables.isNotEmpty).toList();
                    final day = daysWithSchedules.isNotEmpty
                        ? daysWithSchedules[0]
                        : (days.isNotEmpty ? days[0] : null);
                    if (day != null) {
                      _showAddLectureDialog(context, day);
                    }
                  },
                ),
            ],
          ),
          16.verticalSpace,
          CustomPickerField(
            data: List.generate(
              numberOfMajorYears,
              (index) => DropDownData(
                  name: '${AppStrings.year} ${index + 1}', id: '${index + 1}'),
            ),
            hintText: AppStrings.chooseYear,
            onSelect: _onYearSelected,
            selectedItem: selectedYear != null
                ? DropDownData(
                    name: '${AppStrings.year} $selectedYear',
                    id: '$selectedYear')
                : null,
            enableSearch: false,
            width: 200.w,
            isLoading: false,
            readOnly: false,
          ),
          24.verticalSpace,
          if (selectedYear != null) ...[
            // Always show MonthSelector when year is selected
            BlocProvider.value(
              value: getIt<TimeTableBloc>(),
              child: MonthSelector(
                majorYear: selectedYear!,
                onMonthChanged: (newMonth, year) {
                  getIt<TimeTableBloc>().add(GetTimeTableEvent(
                    month: DateTime(year, newMonth),
                    majorYear: selectedYear!,
                  ));
                },
              ),
            ),
            16.verticalSpace,
            Expanded(
              child: BlocProvider.value(
                value: getIt<TimeTableBloc>(),
                child: BlocBuilder<TimeTableBloc, TimeTableState>(
                  builder: (context, state) {
                    if (state.result.isLoading()) {
                      return const LoadingProgress();
                    }
                    final monthData = state.result.getDataWhenSuccess();
                    if (monthData == null || monthData.daysTimeTables.isEmpty) {
                      return NoSchedulesWidget(
                        isError: false,
                        onRetry: () {
                          final now = DateTime.now();
                          getIt<TimeTableBloc>().add(GetTimeTableEvent(
                            month: DateTime(now.year, now.month),
                            majorYear: selectedYear!,
                          ));
                        },
                      );
                    }
                    return _ScheduleContent(monthData: monthData);
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScheduleContent extends StatefulWidget {
  final MonthScheduleEntity monthData;
  const _ScheduleContent({required this.monthData});

  @override
  State<_ScheduleContent> createState() => _ScheduleContentState();
}

class _ScheduleContentState extends State<_ScheduleContent> {
  int selectedDayIndex = 0;
  bool showSuccessSnackBar = false;

  @override
  Widget build(BuildContext context) {
    final days = widget.monthData.daysTimeTables;
    final daysWithSchedules =
        days.where((day) => day.timetables.isNotEmpty).toList();
    if (daysWithSchedules.isEmpty) {
      return NoSchedulesWidget(
        isError: false,
        onRetry: null,
      );
    }
    if (selectedDayIndex >= daysWithSchedules.length) {
      selectedDayIndex = 0;
    }
    final selectedDay = daysWithSchedules[selectedDayIndex];
    return BlocListener<TimeTableBloc, TimeTableState>(
      listenWhen: (prev, curr) => prev.operationResult != curr.operationResult,
      listener: (context, state) {
        if (state.operationResult.isLoaded() && showSuccessSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.addLecture} - ${AppStrings.success}'),
              backgroundColor: Colors.green,
            ),
          );
          showSuccessSnackBar = false;
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              DaySelector(
                days: daysWithSchedules,
                selectedDayIndex: selectedDayIndex,
                onDaySelected: (index) =>
                    setState(() => selectedDayIndex = index),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    // Sort lectures by startTime ascending
                    final sortedTimetables =
                        List<TimetableEntity>.from(selectedDay.timetables)
                          ..sort((a, b) => a.startTime.compareTo(b.startTime));
                    return ListView.builder(
                      key: ValueKey<int>(selectedDayIndex),
                      padding:
                          REdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      itemCount: sortedTimetables.length,
                      itemBuilder: (context, index) {
                        return TimetableItem(
                            timetable: sortedTimetables[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
