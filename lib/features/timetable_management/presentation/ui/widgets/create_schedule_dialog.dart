import 'package:intl/intl.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import '../../state/time_table/time_table_bloc.dart';

class CreateScheduleDialog extends StatefulWidget {
  final int selectedYear;

  const CreateScheduleDialog({
    super.key,
    required this.selectedYear,
  });

  @override
  State<CreateScheduleDialog> createState() => _CreateScheduleDialogState();
}

class _CreateScheduleDialogState extends State<CreateScheduleDialog> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.createSchedule),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppStrings.selectDate),
          16.verticalSpace,
          InkWell(
            onTap: () async {
              final firstDay = _getFirstDayOfMonth();
              final lastDay = _getLastDayOfMonth();
              if (firstDay != null && lastDay != null) {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? firstDay,
                  firstDate: firstDay,
                  lastDate: lastDay,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: context.primaryColor,
                            ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              }
            },
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.primaryColor.withValues(alpha: 0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: context.primaryColor,
                    size: 20.r,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                          : AppStrings.selectDate,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: selectedDate != null
                            ? context.textTheme.bodyMedium?.color
                            : context.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        BlocConsumer<TimeTableBloc, TimeTableState>(
          listener: (context, state) {
            if (state.operationResult.isLoaded()) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return TextButton(
              onPressed:
                  (selectedDate == null || state.operationResult.isLoading())
                      ? null
                      : () {
                          final scheduleDate =
                              DateFormat('yyyy-MM-dd').format(selectedDate!);
                          getIt<TimeTableBloc>().add(
                            CreateScheduleEvent(
                              year: widget.selectedYear,
                              scheduleDate: scheduleDate,
                            ),
                          );
                        },
              child: state.operationResult.isLoading()
                  ? SizedBox(
                      width: 16.r,
                      height: 16.r,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(AppStrings.create),
            );
          },
        ),
      ],
    );
  }

  DateTime? _getFirstDayOfMonth() {
    final currentMonth = TimeTableBloc.selectedDateTime;
    return DateTime(currentMonth.year, currentMonth.month, 1);
  }

  DateTime? _getLastDayOfMonth() {
    final currentMonth = TimeTableBloc.selectedDateTime;
    return DateTime(currentMonth.year, currentMonth.month + 1, 0);
  }
}
