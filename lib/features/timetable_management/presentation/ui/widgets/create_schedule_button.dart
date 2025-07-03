import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import '../../providers/timetable_provider.dart';
import '../../state/time_table/time_table_bloc.dart';
import 'create_schedule_dialog.dart';

class CreateScheduleButton extends StatelessWidget {
  const CreateScheduleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimetableProvider>(
      builder: (context, provider, child) {
        if (provider.selectedYear == null) return const SizedBox.shrink();

        return BlocConsumer<TimeTableBloc, TimeTableState>(
          listener: (context, state) {
            if (state.operationResult.isLoaded() &&
                provider.isCreatingSchedule) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.scheduleCreatedSuccessfully),
                  backgroundColor: Colors.green,
                ),
              );
              provider.setIsCreatingSchedule(false);
            }
            if (state.operationResult.isError()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.operationResult.getError()),
                  backgroundColor: Colors.red,
                ),
              );
              provider.setIsCreatingSchedule(false);
            }
          },
          builder: (context, state) {
            return TextButton.icon(
              icon: state.operationResult.isLoading()
                  ? SizedBox(
                      width: 16.r,
                      height: 16.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.schedule, color: Colors.white),
              label: Text(AppStrings.createSchedule,
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: state.operationResult.isLoading()
                  ? null
                  : () {
                      provider.setIsCreatingSchedule(true);
                      _showCreateScheduleDialog(
                          context, provider.selectedYear!);
                    },
            );
          },
        );
      },
    );
  }

  void _showCreateScheduleDialog(BuildContext context, int selectedYear) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: getIt<TimeTableBloc>(),
          child: CreateScheduleDialog(selectedYear: selectedYear),
        );
      },
    );
  }
}
