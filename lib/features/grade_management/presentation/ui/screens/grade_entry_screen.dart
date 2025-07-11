import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/features/grade_management/presentation/state/bloc/grade_management_bloc.dart';
import 'package:uni_sphere_admin/features/generate_otp/data/param/subject_grade.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_shimmer.dart';
import 'package:uni_sphere_admin/shared/widgets/spacing.dart';
import 'package:uni_sphere_admin/shared/widgets/failed_widget.dart';

import '../../../../../router/router_config.dart' show BeamerBuilder;

class GradeEntryScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;
  final int year;
  const GradeEntryScreen(
      {super.key,
      required this.subjectId,
      required this.subjectName,
      required this.year});

  static BeamerBuilder pageBuilder = (context, state, data) {
    final subjectId = state.queryParameters['subjectId'] ?? '';
    final subjectName = state.queryParameters['subjectName'] ?? '';
    final year = int.tryParse(state.queryParameters['year'] ?? '') ?? 1;
    return BeamPage(
      key: const ValueKey('grade_entry_screen'),
      child: GradeEntryScreen(
        subjectId: subjectId,
        subjectName: subjectName,
        year: year,
      ),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<GradeEntryScreen> createState() => _GradeEntryScreenState();
}

class _GradeEntryScreenState extends State<GradeEntryScreen> {
  final form = FormGroup({});

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<InfoBloc>()),
          BlocProvider.value(value: getIt<GradeManagementBloc>()),
        ],
        child: Padding(
          padding: REdgeInsets.symmetric(
              horizontal: AppConstants.horizontalScreensPadding),
          child: CustomScaffoldBody(
            title: AppStrings.assignGrades,
            child: BlocBuilder<InfoBloc, InfoState>(
              builder: (context, state) {
                final students = state.students.getDataWhenSuccess() ?? [];
                if (state.students.isLoading()) {
                  // Modern shimmer loading
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, i) => Padding(
                      padding: REdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  context.primaryColor.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: REdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmerWidget(
                                height: 18, width: 120, borderRadius: 8),
                            verticalSpace(8),
                            CustomShimmerWidget(
                                height: 16, width: 80, borderRadius: 8),
                            verticalSpace(16),
                            CustomShimmerWidget(
                                height: 44,
                                width: double.infinity,
                                borderRadius: 8),
                            verticalSpace(12),
                            CustomShimmerWidget(
                                height: 44,
                                width: double.infinity,
                                borderRadius: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state.students.isError()) {
                  return FailedWidget(
                    error: state.students.getError(),
                    onPressed: () {
                      context.read<InfoBloc>().add(
                            GetStudentForSubjectEvent(
                                subjectId: widget.subjectId),
                          );
                    },
                    retryText: "Try Again",
                  );
                }

                if (students.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noStudentsFound,
                      style: context.textTheme.titleMedium,
                    ),
                  );
                }

                // Build form controls for each student if not already present
                for (final student in students) {
                  form.addAll({
                    'midterm_${student.id}': FormControl<String>(),
                    'final_${student.id}': FormControl<String>(),
                  });
                }

                return ReactiveForm(
                  formGroup: form,
                  child: Column(
                    children: [
                      verticalSpace(16),
                      Text(widget.subjectName,
                          style: context.textTheme.titleLarge),
                      verticalSpace(16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: students.length,
                          separatorBuilder: (_, __) => verticalSpace(12),
                          itemBuilder: (context, index) {
                            final student = students[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: context.primaryColor
                                        .withValues(alpha: 0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: REdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  verticalSpace(4),
                                  Text(
                                    student.studentNumber ?? '',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(color: context.greyColor),
                                  ),
                                  verticalSpace(16),
                                  CustomReactiveField(
                                    controller: 'midterm_${student.id}',
                                    title: AppStrings.enterMidtermGrade,
                                    keyboardType: TextInputType.number,
                                    hintText: AppStrings.enterMidtermGrade,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                  verticalSpace(12),
                                  CustomReactiveField(
                                    controller: 'final_${student.id}',
                                    title: AppStrings.enterFinalGrade,
                                    keyboardType: TextInputType.number,
                                    hintText: AppStrings.enterFinalGrade,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      verticalSpace(24),
                      BlocConsumer<GradeManagementBloc, GradeManagementState>(
                        listener: (context, state) {
                          if (state.result.isLoaded()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text(AppStrings.gradesAssignedSuccess),
                                  backgroundColor: Colors.green),
                            );
                            context.beamBack();
                          } else if (state.result.isError()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(AppStrings.gradesAssignedError),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        builder: (context, state) {
                          return AuthButton.primary(
                            title: AppStrings.uploadGrades,
                            isLoading: state.result.isLoading(),
                            onPressed: () {
                              final List<StudentGrade> grades = [];
                              for (final student in students) {
                                final midText = form
                                        .control('midterm_${student.id}')
                                        .value ??
                                    '';
                                final finText =
                                    form.control('final_${student.id}').value ??
                                        '';
                                final mid = int.tryParse(midText);
                                final fin = int.tryParse(finText);
                                // Only add if at least one grade is entered and valid
                                if ((mid != null && midText.isNotEmpty) ||
                                    (fin != null && finText.isNotEmpty)) {
                                  grades.add(StudentGrade(
                                    studentId: student.id,
                                    midTermGrade: mid ?? 0,
                                    finalGrade: fin ?? 0,
                                  ));
                                }
                              }
                              if (grades.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(AppStrings.thisFieldRequired),
                                      backgroundColor: Colors.red),
                                );
                                return;
                              }
                              context.read<GradeManagementBloc>().add(
                                    AssignGradesToSubjectEvent(
                                      subjectGrade: SubjectGrade(
                                        subjectId: widget.subjectId,
                                        studentGrades: grades,
                                      ),
                                    ),
                                  );
                            },
                            context: context,
                          );
                        },
                      ),
                      verticalSpace(24),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
