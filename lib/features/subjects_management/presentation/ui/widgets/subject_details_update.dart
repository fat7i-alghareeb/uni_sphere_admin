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
  late FormGroup _formGroup;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _formGroup = FormGroup({
      'year': FormControl<int>(
        value: widget.subject.year,
        validators: [Validators.required, Validators.min(1), Validators.max(4)],
      ),
      'semester': FormControl<int>(
        value: widget.subject.semester,
        validators: [Validators.required, Validators.min(1), Validators.max(2)],
      ),
      'midtermGrade': FormControl<double>(
        value: widget.subject.midtermGrade,
        validators: [Validators.min(0), Validators.max(100)],
      ),
      'finalGrade': FormControl<double>(
        value: widget.subject.finalGrade,
        validators: [Validators.min(0), Validators.max(100)],
      ),
      'isLabRequired': FormControl<bool>(
        value: widget.subject.isLabRequired,
      ),
      'isMultipleChoice': FormControl<bool>(
        value: widget.subject.isMultipleChoice,
      ),
    });
  }

  @override
  void dispose() {
    _formGroup.dispose();
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
          // Success - hide the form and call callback
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
                _initializeForm(); // Reset form when canceling
              }
            });
          },
          icon: Icon(
            _isEditing ? Icons.close : Icons.edit,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateForm(BuildContext context, SubjectState state) {
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
        formGroup: _formGroup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormFields(context),
            16.verticalSpace,
            _buildUpdateButton(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        // Year and Semester in a responsive row
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Wide screen - side by side
              return Row(
                children: [
                  Expanded(
                    child: CustomReactiveField(
                      controller: 'year',
                      hintText: AppStrings.year,
                      title: AppStrings.year,
                      keyboardType: TextInputType.number,
                      isRequired: true,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: CustomReactiveField(
                      controller: 'semester',
                      hintText: AppStrings.semester,
                      title: AppStrings.semester,
                      keyboardType: TextInputType.number,
                      isRequired: true,
                    ),
                  ),
                ],
              );
            } else {
              // Narrow screen - stacked
              return Column(
                children: [
                  CustomReactiveField(
                    controller: 'year',
                    hintText: AppStrings.year,
                    title: AppStrings.year,
                    keyboardType: TextInputType.number,
                    isRequired: true,
                  ),
                  16.verticalSpace,
                  CustomReactiveField(
                    controller: 'semester',
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
        // Midterm and Final grades in a responsive row
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Wide screen - side by side
              return Row(
                children: [
                  Expanded(
                    child: CustomReactiveField(
                      controller: 'midtermGrade',
                      hintText: AppStrings.midtermGrade,
                      title: AppStrings.midtermGrade,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: CustomReactiveField(
                      controller: 'finalGrade',
                      hintText: AppStrings.finalGrade,
                      title: AppStrings.finalGrade,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              );
            } else {
              // Narrow screen - stacked
              return Column(
                children: [
                  CustomReactiveField(
                    controller: 'midtermGrade',
                    hintText: AppStrings.midtermGrade,
                    title: AppStrings.midtermGrade,
                    keyboardType: TextInputType.number,
                  ),
                  16.verticalSpace,
                  CustomReactiveField(
                    controller: 'finalGrade',
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
        // Boolean fields in a responsive row
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Wide screen - side by side
              return Row(
                children: [
                  Expanded(
                    child: _buildBooleanField(
                        context, 'isLabRequired', AppStrings.isLabRequired),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: _buildBooleanField(context, 'isMultipleChoice',
                        AppStrings.isMultipleChoice),
                  ),
                ],
              );
            } else {
              // Narrow screen - stacked
              return Column(
                children: [
                  _buildBooleanField(
                      context, 'isLabRequired', AppStrings.isLabRequired),
                  16.verticalSpace,
                  _buildBooleanField(
                      context, 'isMultipleChoice', AppStrings.isMultipleChoice),
                ],
              );
            }
          },
        ),
      ],
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

  Widget _buildUpdateButton(BuildContext context, SubjectState state) {
    final isLoading = state.operationResult.isLoading();
    final isValid = _formGroup.valid;

    return SizedBox(
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  8.horizontalSpace,
                  Text(AppStrings.updating),
                ],
              )
            : Text(AppStrings.updateSubject),
      ),
    );
  }

  void _updateSubject() {
    if (!_formGroup.valid) return;

    final updates = <UpdateSubjectParam>[];

    // Check for changes and add to updates list
    if (_formGroup.control('year').value != widget.subject.year) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('year').value,
        field: SubjectPatchFields.year,
      ));
    }

    if (_formGroup.control('semester').value != widget.subject.semester) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('semester').value,
        field: SubjectPatchFields.semester,
      ));
    }

    if (_formGroup.control('midtermGrade').value !=
        widget.subject.midtermGrade) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('midtermGrade').value,
        field: SubjectPatchFields.midTermGrade,
      ));
    }

    if (_formGroup.control('finalGrade').value != widget.subject.finalGrade) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('finalGrade').value,
        field: SubjectPatchFields.finalGrade,
      ));
    }

    if (_formGroup.control('isLabRequired').value !=
        widget.subject.isLabRequired) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('isLabRequired').value,
        field: SubjectPatchFields.isLabRequired,
      ));
    }

    if (_formGroup.control('isMultipleChoice').value !=
        widget.subject.isMultipleChoice) {
      updates.add(UpdateSubjectParam(
        newValue: _formGroup.control('isMultipleChoice').value,
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
