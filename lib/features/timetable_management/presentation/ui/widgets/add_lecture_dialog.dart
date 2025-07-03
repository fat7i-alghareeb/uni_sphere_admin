import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/entities/subject_info.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import 'package:uni_sphere_admin/features/timetable_management/data/param/add_lecutre.dart';
import 'package:uni_sphere_admin/features/timetable_management/presentation/input_forms/add_lecture_form.dart';
import 'package:uni_sphere_admin/features/timetable_management/presentation/input_forms/add_lecture_input_keys.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/extensions/date_time_extension.dart';
import 'package:uni_sphere_admin/shared/widgets/loading_progress.dart';

class AddLectureDialog extends StatefulWidget {
  final String scheduleId;
  final String dayName;
  final int year;
  final Future<bool> Function(AddLectureParam param)? onSubmit;

  const AddLectureDialog({
    super.key,
    required this.scheduleId,
    required this.dayName,
    required this.year,
    this.onSubmit,
  });

  @override
  State<AddLectureDialog> createState() => _AddLectureDialogState();
}

class _AddLectureDialogState extends State<AddLectureDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  DropDownData? selectedSubject;
  String? _startTimeDisplay;
  String? _endTimeDisplay;
  String? _startTimeBackend;
  String? _endTimeBackend;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
    AddLectureForm.clearForm();
    // Fetch subjects
    getIt<InfoBloc>().add(GetMyMajorSubjectsEvent(year: widget.year));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<InfoBloc>(),
      child: Stack(
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.85,
                    maxWidth: MediaQuery.of(context).size.width * 0.95,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      Flexible(
                        child: SingleChildScrollView(
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: _buildForm(),
                        ),
                      ),
                      _buildActions(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const LoadingProgress(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 24.r,
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              '${AppStrings.addLecture} - ${widget.dayName}',
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 24.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        final subjectsResult = state.myMajorSubjects;
        List<DropDownData> subjectOptions = [];
        if (subjectsResult.isLoaded() &&
            subjectsResult.getDataWhenSuccess() != null) {
          subjectOptions = subjectsResult
              .getDataWhenSuccess()!
              .map((s) => DropDownData(name: s.name, id: s.id))
              .toList();
        }
        return ReactiveForm(
          formGroup: AddLectureForm.formGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.subjectInformation,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              12.verticalSpace,
              CustomPickerField(
                data: subjectOptions,
                hintText: AppStrings.subjectName,
                onSelect: (name, id) {
                  AddLectureForm.formGroup
                      .control(AddLectureInputKeys.subjectId)
                      .value = id;
                  setState(() {
                    selectedSubject = subjectOptions.firstWhere(
                        (element) => element.id == id,
                        orElse: () => DropDownData(name: name, id: id));
                  });
                },
                selectedItem: selectedSubject,
                enableSearch: true,
                width: double.infinity,
                isLoading: subjectsResult.isLoading(),
                readOnly: false,
                isItemRequired: true,
              ),
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomReactiveField(
                      controller: AddLectureInputKeys.startTime,
                      hintText: AppStrings.startTime,
                      initialValue: _startTimeDisplay,
                      title: AppStrings.startTime,
                      isRequired: true,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onTap: (control) async {
                        final now = TimeOfDay.now();
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: now,
                        );
                        if (picked != null) {
                          final timeString =
                              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
                          _startTimeBackend = timeString;
                          setState(() {
                            _startTimeDisplay = timeString.toAmPmTime();
                          });
                          AddLectureForm.formGroup
                              .control(AddLectureInputKeys.startTime)
                              .value = _startTimeDisplay;
                        }
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CustomReactiveField(
                      controller: AddLectureInputKeys.endTime,
                      hintText: AppStrings.endTime,
                      initialValue: _endTimeDisplay,
                      title: AppStrings.endTime,
                      isRequired: true,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onTap: (control) async {
                        final now = TimeOfDay.now();
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: now,
                        );
                        if (picked != null) {
                          final timeString =
                              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
                          _endTimeBackend = timeString;
                          setState(() {
                            _endTimeDisplay = timeString.toAmPmTime();
                          });
                          AddLectureForm.formGroup
                              .control(AddLectureInputKeys.endTime)
                              .value = _endTimeDisplay;
                        }
                      },
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              CustomReactiveField(
                controller: AddLectureInputKeys.lectureHallEn,
                hintText: AppStrings.lectureHallEn,
                title: AppStrings.lectureHallEn,
                isRequired: true,
                keyboardType: TextInputType.text,
              ),
              12.verticalSpace,
              CustomReactiveField(
                controller: AddLectureInputKeys.lectureHallAr,
                hintText: AppStrings.lectureHallAr,
                title: AppStrings.lectureHallAr,
                isRequired: true,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActions() {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                if (!_isLoading) Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancel),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: AuthButton.primary(
              title: AppStrings.addLecture,
              onPressed: _isLoading ? () {} : () => _submitForm(),
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (!AddLectureForm.formGroup.valid) {
      showErrorOverlay(context, AppStrings.thisFieldRequired);
      return;
    }
    final form = AddLectureForm.formGroup;
    final param = AddLectureParam(
      subjectId: form.control(AddLectureInputKeys.subjectId).value,
      startTime: _startTimeBackend ?? '',
      endTime: _endTimeBackend ?? '',
      lectureHallEn: form.control(AddLectureInputKeys.lectureHallEn).value,
      lectureHallAr: form.control(AddLectureInputKeys.lectureHallAr).value,
    );
    setState(() => _isLoading = true);
    bool success = true;
    if (widget.onSubmit != null) {
      success = await widget.onSubmit!(param);
    } else {
      // fallback: just pop immediately
      Navigator.of(context).pop(param);
      return;
    }
    setState(() => _isLoading = false);
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }
}
