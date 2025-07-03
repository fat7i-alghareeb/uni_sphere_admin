import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/entities/user.dart';
import '../../providers/timetable_provider.dart';
import '../../../../../core/injection/injection.dart';
import '../../state/time_table/time_table_bloc.dart';

class YearSelector extends StatelessWidget {
  final int numberOfMajorYears;
  final User user;

  const YearSelector({
    super.key,
    required this.numberOfMajorYears,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TimetableProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.selectMajorYear,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            16.verticalSpace,
            CustomPickerField(
              data: List.generate(
                numberOfMajorYears,
                (index) => DropDownData(
                    name: '${AppStrings.year} ${index + 1}',
                    id: '${index + 1}'),
              ),
              hintText: AppStrings.chooseYear,
              onSelect: (name, id) => _onYearSelected(context, id),
              selectedItem: provider.selectedYear != null
                  ? DropDownData(
                      name: '${AppStrings.year} ${provider.selectedYear}',
                      id: '${provider.selectedYear}')
                  : null,
              enableSearch: false,
              width: 200.w,
              isLoading: false,
              readOnly: false,
            ),
          ],
        );
      },
    );
  }

  void _onYearSelected(BuildContext context, String? id) {
    final year = int.tryParse(id ?? '');
    if (year != null) {
      final provider = context.read<TimetableProvider>();
      provider.setSelectedYear(year);

      final now = DateTime.now();
      getIt<TimeTableBloc>().add(GetTimeTableEvent(
        month: DateTime(now.year, now.month),
        majorYear: year,
      ));
    }
  }
}
