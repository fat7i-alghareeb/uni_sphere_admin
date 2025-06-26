import 'package:reactive_forms/reactive_forms.dart' show ReactiveFormConsumer;
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../input_forms/auth_input_keys.dart';
import '../../../../../shared/entities/drop_down_data.dart';
import '../../../../../shared/extensions/form_extension.dart';
import '../../../../../shared/widgets/custom_picker.dart'
    show CustomPickerField;

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/states/bloc/info_bloc.dart';
import '../../../../../shared/utils/helper/show_error_overlay.dart';
import '../../input_forms/check_one_time_code_from.dart';

class MajorSelector extends StatelessWidget {
  const MajorSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InfoBloc, InfoState>(
      listener: (context, state) {
        if (state.faculties.isError()) {
          showErrorOverlay(context, state.faculties.getError());
        }
        if (state.majors.isError()) {
          showErrorOverlay(context, state.majors.getError());
        }
      },
      builder: (context, state) {
        return ReactiveFormConsumer(builder: (context, form, child) {
          return Column(
            children: [
              CustomPickerField(
                formGroup: CheckOneTimeCodeForm.formGroup,
                controller: AuthInputKeys.faculty,
                data: state.faculties
                        .getDataWhenSuccess()
                        ?.map((e) => DropDownData(
                              id: e.id,
                              name: e.name,
                            ))
                        .toList() ??
                    [],
                hintText: AppStrings.selectFaculty,
                title: AppStrings.selectFaculty,
                onSelect: (value, id) {
                  form.setValue(AuthInputKeys.faculty, value);
                  form.setValue(AuthInputKeys.facultyId, id);
                  if (id != null) {
                    getIt<InfoBloc>().add(GetMajorsEvent(facultyId: id));
                  } else {
                    form.setValue(AuthInputKeys.major, "");
                    form.setValue(AuthInputKeys.majorId, "");
                    // Disable form when faculty is cleared
                    form.markAsDisabled();
                    form.setValue(AuthInputKeys.email, null);
                    form.setValue(AuthInputKeys.oneTimeCode, null);
                  }
                },
                selectedItem: DropDownData(
                  name: form.getValue(AuthInputKeys.faculty),
                  id: form.getValue(AuthInputKeys.facultyId),
                ),
                enableSearch: true,
                width: double.infinity,
                isLoading: state.faculties.isLoading(),
                readOnly: false,
              ),
              10.verticalSpace,
              CustomPickerField(
                formGroup: CheckOneTimeCodeForm.formGroup,
                controller: AuthInputKeys.major,
                data: state.majors
                        .getDataWhenSuccess()
                        ?.map((e) => DropDownData(
                              id: e.id,
                              name: e.name,
                            ))
                        .toList() ??
                    [],
                hintText: AppStrings.selectMajor,
                title: AppStrings.selectMajor,
                onSelect: (value, id) {
                  form.setValue(AuthInputKeys.major, value);
                  form.setValue(AuthInputKeys.majorId, id);
                  if (id == null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    form.markAsDisabled();
                    form.setValue(AuthInputKeys.email, null);
                    form.setValue(AuthInputKeys.oneTimeCode, null);
                  } else {
                    form.markAsEnabled();
                  }
                },
                selectedItem: DropDownData(
                  name: form.getValue(AuthInputKeys.major),
                  id: form.getValue(AuthInputKeys.majorId),
                ),
                enableSearch: true,
                width: double.infinity,
                isLoading: state.majors.isLoading(),
                readOnly: form.getValue(AuthInputKeys.facultyId) == null ||
                    state.majors.isError(),
              ),
            ],
          );
        });
      },
    );
  }
}
