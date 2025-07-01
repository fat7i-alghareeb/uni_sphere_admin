import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/params/update_param.dart';
import 'package:uni_sphere_admin/features/subjects_management/domain/entities/subject_patch_field.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';

// Form keys for maintainability
class SubjectDetailsUpdateFormKeys {
  static const year = 'year';
  static const semester = 'semester';
  static const midtermGrade = 'midtermGrade';
  static const finalGrade = 'finalGrade';
  static const isLabRequired = 'isLabRequired';
  static const isMultipleChoice = 'isMultipleChoice';
}

// Form builder for SubjectDetailsUpdate
class SubjectDetailsUpdateForm {
  static FormGroup build(Subject subject) {
    return FormGroup({
      SubjectDetailsUpdateFormKeys.year: FormControl<int>(
        value: subject.year,
        validators: [Validators.required, Validators.min(1), Validators.max(4)],
      ),
      SubjectDetailsUpdateFormKeys.semester: FormControl<int>(
        value: subject.semester,
        validators: [Validators.required, Validators.min(1), Validators.max(2)],
      ),
      SubjectDetailsUpdateFormKeys.midtermGrade: FormControl<double>(
        value: subject.midtermGrade,
        validators: [Validators.min(0), Validators.max(100)],
      ),
      SubjectDetailsUpdateFormKeys.finalGrade: FormControl<double>(
        value: subject.finalGrade,
        validators: [Validators.min(0), Validators.max(100)],
      ),
      SubjectDetailsUpdateFormKeys.isLabRequired: FormControl<bool>(
        value: subject.isLabRequired,
      ),
      SubjectDetailsUpdateFormKeys.isMultipleChoice: FormControl<bool>(
        value: subject.isMultipleChoice,
      ),
    });
  }
}

class SubjectDetailsUpdate extends StatefulWidget {
  const SubjectDetailsUpdate({
    super.key,
    required this.subject,
    required this.onSubjectUpdated,
  });

  final Subject subject;
  final VoidCallback onSubjectUpdated;

  @override
  State<SubjectDetailsUpdate> createState() => _SubjectDetailsUpdateState();
}

class _SubjectDetailsUpdateState extends State<SubjectDetailsUpdate> {
  FormGroup? _formGroup;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void didUpdateWidget(SubjectDetailsUpdate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.subject.id != widget.subject.id) {
      _initializeForm();
    }
  }

  void _initializeForm() {
    _formGroup?.dispose();
    _formGroup = SubjectDetailsUpdateForm.build(widget.subject);
  }

  @override
  void dispose() {
    _formGroup?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AppConstants.userRole != Role.superadmin) {
      return const SizedBox.shrink();
    }
    return BlocConsumer<GetSubjectsBloc, SubjectState>(
      listenWhen: (previous, current) =>
          previous.operationResult != current.operationResult,
      listener: (context, state) {
        if (state.operationResult.isLoaded()) {
          setState(() {
            _isEditing = false;
          });
          widget.onSubjectUpdated();
        }
      },
      buildWhen: (previous, current) =>
          previous.operationResult != current.operationResult,
      builder: (context, state) {
        return Container(
          padding: REdgeInsets.symmetric(
            horizontal: AppConstants.horizontalScreensPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              16.verticalSpace,
              if (_isEditing) _buildUpdateForm(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.updateSubject,
          style: context.textTheme.titleLarge!.withColor(context.primaryColor),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _isEditing = !_isEditing;
              if (!_isEditing) {
                _initializeForm();
              }
            });
          },
          icon: Icon(
            _isEditing ? Icons.close : Icons.edit,
            color: context.primaryColor,
          ),
          tooltip: _isEditing ? AppStrings.cancel : AppStrings.edit,
        ),
      ],
    );
  }

  Widget _buildUpdateForm(BuildContext context, SubjectState state) {
    if (_formGroup == null) {
      return Container(
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    final isLoading = state.operationResult.isLoading();
    final isValid = _formGroup?.valid ?? false;
    // Controllers for easy access
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ReactiveForm(
        formGroup: _formGroup!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Year and Semester
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomReactiveField(
                          controller: SubjectDetailsUpdateFormKeys.year,
                          hintText: AppStrings.year,
                          title: AppStrings.year,
                          keyboardType: TextInputType.number,
                          isRequired: true,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomReactiveField(
                          controller: SubjectDetailsUpdateFormKeys.semester,
                          hintText: AppStrings.semester,
                          title: AppStrings.semester,
                          keyboardType: TextInputType.number,
                          isRequired: true,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      CustomReactiveField(
                        controller: SubjectDetailsUpdateFormKeys.year,
                        hintText: AppStrings.year,
                        title: AppStrings.year,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                      16.verticalSpace,
                      CustomReactiveField(
                        controller: SubjectDetailsUpdateFormKeys.semester,
                        hintText: AppStrings.semester,
                        title: AppStrings.semester,
                        keyboardType: TextInputType.number,
                        isRequired: true,
                      ),
                    ],
                  );
                }
              },
            ),
            16.verticalSpace,
            // Midterm and Final grades
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomReactiveField(
                          controller: SubjectDetailsUpdateFormKeys.midtermGrade,
                          hintText: AppStrings.midtermGrade,
                          title: AppStrings.midtermGrade,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomReactiveField(
                          controller: SubjectDetailsUpdateFormKeys.finalGrade,
                          hintText: AppStrings.finalGrade,
                          title: AppStrings.finalGrade,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      CustomReactiveField(
                        controller: SubjectDetailsUpdateFormKeys.midtermGrade,
                        hintText: AppStrings.midtermGrade,
                        title: AppStrings.midtermGrade,
                        keyboardType: TextInputType.number,
                      ),
                      16.verticalSpace,
                      CustomReactiveField(
                        controller: SubjectDetailsUpdateFormKeys.finalGrade,
                        hintText: AppStrings.finalGrade,
                        title: AppStrings.finalGrade,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  );
                }
              },
            ),
            16.verticalSpace,
            // Boolean fields
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: _buildBooleanField(
                            context,
                            SubjectDetailsUpdateFormKeys.isLabRequired,
                            AppStrings.isLabRequired),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: _buildBooleanField(
                            context,
                            SubjectDetailsUpdateFormKeys.isMultipleChoice,
                            AppStrings.isMultipleChoice),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildBooleanField(
                          context,
                          SubjectDetailsUpdateFormKeys.isLabRequired,
                          AppStrings.isLabRequired),
                      16.verticalSpace,
                      _buildBooleanField(
                          context,
                          SubjectDetailsUpdateFormKeys.isMultipleChoice,
                          AppStrings.isMultipleChoice),
                    ],
                  );
                }
              },
            ),
            16.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isValid && !isLoading ? _updateSubject : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  foregroundColor: Colors.white,
                  padding: REdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.r,
                            height: 20.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          8.horizontalSpace,
                          Text(AppStrings.updating),
                        ],
                      )
                    : Text(AppStrings.updateSubject),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooleanField(
      BuildContext context, String controller, String title) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final value = form.control(controller).value as bool? ?? false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.bodyMedium!
                  .withColor(context.onBackgroundColor),
            ),
            8.verticalSpace,
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: context.greyColor.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButtonFormField<bool>(
                value: value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: [
                  DropdownMenuItem(value: true, child: Text(AppStrings.yes)),
                  DropdownMenuItem(value: false, child: Text(AppStrings.no)),
                ],
                onChanged: (newValue) {
                  form.control(controller).value = newValue;
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateSubject() {
    if (_formGroup == null || !_formGroup!.valid) return;
    final updates = <UpdateSubjectParam>[];
    final form = _formGroup!;
    if (form.control(SubjectDetailsUpdateFormKeys.year).value !=
        widget.subject.year) {
      updates.add(UpdateSubjectParam(
        newValue: form.control(SubjectDetailsUpdateFormKeys.year).value,
        field: SubjectPatchFields.year,
      ));
    }
    if (form.control(SubjectDetailsUpdateFormKeys.semester).value !=
        widget.subject.semester) {
      updates.add(UpdateSubjectParam(
        newValue: form.control(SubjectDetailsUpdateFormKeys.semester).value,
        field: SubjectPatchFields.semester,
      ));
    }
    if (form.control(SubjectDetailsUpdateFormKeys.midtermGrade).value !=
        widget.subject.midtermGrade) {
      updates.add(UpdateSubjectParam(
        newValue: form.control(SubjectDetailsUpdateFormKeys.midtermGrade).value,
        field: SubjectPatchFields.midTermGrade,
      ));
    }
    if (form.control(SubjectDetailsUpdateFormKeys.finalGrade).value !=
        widget.subject.finalGrade) {
      updates.add(UpdateSubjectParam(
        newValue: form.control(SubjectDetailsUpdateFormKeys.finalGrade).value,
        field: SubjectPatchFields.finalGrade,
      ));
    }
    if (form.control(SubjectDetailsUpdateFormKeys.isLabRequired).value !=
        widget.subject.isLabRequired) {
      updates.add(UpdateSubjectParam(
        newValue:
            form.control(SubjectDetailsUpdateFormKeys.isLabRequired).value,
        field: SubjectPatchFields.isLabRequired,
      ));
    }
    if (form.control(SubjectDetailsUpdateFormKeys.isMultipleChoice).value !=
        widget.subject.isMultipleChoice) {
      updates.add(UpdateSubjectParam(
        newValue:
            form.control(SubjectDetailsUpdateFormKeys.isMultipleChoice).value,
        field: SubjectPatchFields.isMultipleChoice,
      ));
    }
    if (updates.isNotEmpty) {
      final bloc = getIt<GetSubjectsBloc>();
      bloc.add(UpdateSubjectEvent(
        id: widget.subject.id,
        fields: updates,
      ));
    }
  }
}
