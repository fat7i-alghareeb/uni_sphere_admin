import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_sphere_admin/shared/entities/user.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/core/constants/app_constants.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import '../../providers/timetable_provider.dart';
import '../../state/time_table/time_table_bloc.dart';
import '../widgets/year_selector.dart';
import '../widgets/create_schedule_button.dart';
import '../widgets/schedule_content.dart';

class ScheduleView extends StatefulWidget {
  final User user;
  const ScheduleView({super.key, required this.user});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late int numberOfMajorYears;

  @override
  void initState() {
    super.initState();
    numberOfMajorYears = widget.user.numberOfMajorYears ?? 4;
  }

  @override
  Widget build(BuildContext context) {
    if (AppConstants.userRole != Role.admin) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.timetable),
          backgroundColor: context.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Center(child: Text(AppStrings.notAuthorized)),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => TimetableProvider(),
      child: BlocProvider.value(
        value: getIt<TimeTableBloc>(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalScreensPadding),
              child: YearSelector(
                numberOfMajorYears: numberOfMajorYears,
                user: widget.user,
              ),
            ),
            10.verticalSpace,
            const CreateScheduleButton(),
            12.verticalSpace,
            Consumer<TimetableProvider>(
              builder: (context, provider, child) {
                if (provider.selectedYear == null) {
                  return const Expanded(
                    child: Center(
                      child: Text('Please select a year to view schedules'),
                    ),
                  );
                }
                return Expanded(
                  child: ScheduleContent(selectedYear: provider.selectedYear!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
