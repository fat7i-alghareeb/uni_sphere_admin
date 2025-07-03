import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/auth_data_source/local/auth_local.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/router/router_config.dart' show BeamerBuilder;
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/shared/extensions/form_extension.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';

class AssignGradesScreen extends StatefulWidget {
  const AssignGradesScreen({super.key});
  static const String pagePath = 'assign_grades';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: const ValueKey('assign_grades_screen'),
      child: const AssignGradesScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  State<AssignGradesScreen> createState() => _AssignGradesScreenState();
}

class _AssignGradesScreenState extends State<AssignGradesScreen> {
  final FormGroup formGroup = FormGroup({
    'year': FormControl<String>(),
    'yearId': FormControl<String>(),
    'subject': FormControl<String>(),
    'subjectId': FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<InfoBloc>(),
      child: BlocConsumer<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state.myMajorSubjects.isError()) {
            showErrorOverlay(context, state.myMajorSubjects.getError());
          }
        },
        builder: (context, state) {
          final user = getIt<AuthLocal>().getUser();
          final numberOfMajorYears = user?.numberOfMajorYears ?? 4;
          List<DropDownData> yearOptions = List.generate(
            numberOfMajorYears,
            (i) => DropDownData(
              id: (i + 1).toString(),
              name: '${AppStrings.year} ${i + 1}',
            ),
          );
          final subjectOptions = state.myMajorSubjects
                  .getDataWhenSuccess()
                  ?.map((s) => DropDownData(id: s.id, name: s.name))
                  .toList() ??
              [];
          return Scaffold(
            body: ReactiveForm(
              formGroup: formGroup,
              child: CustomScaffoldBody(
                title: AppStrings.assignGrades,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                        horizontal: AppConstants.horizontalScreensPadding),
                    child: ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return Column(
                          children: [
                            24.verticalSpace,
                            CustomPickerField(
                              formGroup: form,
                              controller: 'year',
                              data: yearOptions,
                              hintText: AppStrings.selectStudentYear,
                              title: AppStrings.selectStudentYear,
                              onSelect: (value, id) {
                                form.setValue('year', value);
                                form.setValue('yearId', id);
                                form.setValue('subject', '');
                                form.setValue('subjectId', '');
                                if (id != null) {
                                  getIt<InfoBloc>().add(GetMyMajorSubjectsEvent(
                                      year: int.parse(id)));
                                }
                              },
                              selectedItem: DropDownData(
                                name: form.getValue('year'),
                                id: form.getValue('yearId'),
                              ),
                              enableSearch: false,
                              width: double.infinity,
                              isLoading: false,
                              readOnly: false,
                            ),
                            10.verticalSpace,
                            CustomPickerField(
                              formGroup: form,
                              controller: 'subject',
                              data: subjectOptions,
                              hintText: AppStrings.selectSubject,
                              title: AppStrings.selectSubject,
                              onSelect: (value, id) {
                                form.setValue('subject', value);
                                form.setValue('subjectId', id);
                              },
                              selectedItem: DropDownData(
                                name: form.getValue('subject'),
                                id: form.getValue('subjectId'),
                              ),
                              enableSearch: true,
                              width: double.infinity,
                              isLoading: state.myMajorSubjects.isLoading(),
                              readOnly: form.getValue('yearId') == null ||
                                  state.myMajorSubjects.isError(),
                            ),
                            SizedBox(height: 24),
                            AuthButton.primary(
                              title: AppStrings.assignGradesButton,
                              onPressed: (form.getValue('yearId') != null &&
                                      form.getValue('subjectId') != null)
                                  ? () {
                                      getIt<InfoBloc>().add(
                                          GetStudentForSubjectEvent(
                                              subjectId:
                                                  form.getValue('subjectId')));
                                      context.beamToNamed(
                                          'entry?subjectId=${form.getValue('subjectId')}&subjectName=${Uri.encodeComponent(form.getValue('subject') ?? '')}&year=${form.getValue('yearId')}');
                                    }
                                  : () {},
                              isLoading: state.students.isLoading(),
                              context: context,
                            ),
                            SizedBox(height: 24),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
