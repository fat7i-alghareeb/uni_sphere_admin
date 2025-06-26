import 'package:beamer/beamer.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/access/data/params/check_one_time_param.dart';
import 'package:uni_sphere_admin/features/access/presentation/input_forms/auth_input_keys.dart';
import 'package:uni_sphere_admin/features/access/presentation/input_forms/check_one_time_code_from.dart';
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart';
import 'package:uni_sphere_admin/features/access/presentation/ui/screens/register_screen.dart'
    show RegisterScreen;
import 'package:uni_sphere_admin/features/access/presentation/ui/widgets/major_selector.dart';
import 'package:uni_sphere_admin/shared/extensions/form_extension.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/shared/utils/helper/colored_print.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;
import 'package:uni_sphere_admin/shared/entities/role.dart' show Role;
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart'
    show CustomPickerField;
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';

class CheckOneTimeCodeBody extends StatefulWidget {
  const CheckOneTimeCodeBody({
    super.key,
  });

  @override
  State<CheckOneTimeCodeBody> createState() => _CheckOneTimeCodeBodyState();
}

class _CheckOneTimeCodeBodyState extends State<CheckOneTimeCodeBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  // Individual animations for each widget
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _roleSpecificAnimation;
  late Animation<double> _majorSelectorAnimation;
  late Animation<double> _userInfoAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create staggered animations
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.3, curve: Curves.elasticOut),
    ));

    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeOutBack),
    ));

    _roleSpecificAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    ));

    _majorSelectorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 0.8, curve: Curves.easeOutCubic),
    ));

    _userInfoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOutCubic),
    ));

    _buttonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.9, 1.0, curve: Curves.easeOutBack),
    ));

    // Start animations
    _fadeController.forward();
    _animationController.forward();

    // Fetch faculties for admin roles
    if (AuthBloc.selectedRole == Role.admin ||
        AuthBloc.selectedRole == Role.superAdmin) {
      getIt<InfoBloc>().add(GetFacultiesEvent());
    }

    // Clear form when entering screen
    CheckOneTimeCodeForm.clearForm();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();

    // Clear form when leaving screen
    CheckOneTimeCodeForm.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FadeTransition(
        opacity: _fadeController,
        child: ReactiveForm(
          key: ValueKey("check_one_time_code_form"),
          formGroup: CheckOneTimeCodeForm.formGroup,
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppConstants.horizontalScreensPadding,
            ),
            child: CustomScaffoldBody(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    75.verticalSpace,
                    AnimatedBuilder(
                      animation: _logoAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _logoAnimation.value)),
                            child: Container(
                              width: 150.r,
                              height: 150.r,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.school,
                                size: 80.r,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AnimatedBuilder(
                      animation: _titleAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _titleAnimation.value)),
                          child: Opacity(
                            opacity: _titleAnimation.value.clamp(0.0, 1.0),
                            child: Text(
                              AppStrings.checkOneTimeCode,
                              style: context.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                    AnimatedBuilder(
                      animation: _roleSpecificAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              50 * (1 - _roleSpecificAnimation.value), 0),
                          child: Opacity(
                            opacity:
                                _roleSpecificAnimation.value.clamp(0.0, 1.0),
                            child: _roleSpecificFields(),
                          ),
                        );
                      },
                    ),
                    if (AuthBloc.selectedRole == Role.admin)
                      AnimatedBuilder(
                        animation: _majorSelectorAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                50 * (1 - _majorSelectorAnimation.value), 0),
                            child: Opacity(
                              opacity:
                                  _majorSelectorAnimation.value.clamp(0.0, 1.0),
                              child: MajorSelector(),
                            ),
                          );
                        },
                      ),
                    10.verticalSpace,
                    AnimatedBuilder(
                      animation: _userInfoAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(-50 * (1 - _userInfoAnimation.value), 0),
                          child: Opacity(
                            opacity: _userInfoAnimation.value.clamp(0.0, 1.0),
                            child: _userInfo(),
                          ),
                        );
                      },
                    ),
                    50.verticalSpace,
                    AnimatedBuilder(
                      animation: _buttonAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _buttonAnimation.value,
                          child: Opacity(
                            opacity: _buttonAnimation.value.clamp(0.0, 1.0),
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state.checkOneTimeResult.isError()) {
                                  showErrorOverlay(
                                    context,
                                    state.checkOneTimeResult.getError(),
                                  );
                                }
                                if (state.checkOneTimeResult.isLoaded() &&
                                    !AuthBloc.isCheckingOneTimeCode) {
                                  AuthBloc.isCheckingOneTimeCode = true;
                                  context.beamToNamed(RegisterScreen.pagePath);
                                }
                              },
                              builder: (context, state) {
                                // Check if form is ready for submission
                                final isFormReady = (AuthBloc.selectedRole !=
                                            Role.admin &&
                                        AuthBloc.selectedRole !=
                                            Role.superAdmin) ||
                                    (AuthBloc.selectedRole == Role.admin &&
                                        CheckOneTimeCodeForm.formGroup.getValue(
                                                AuthInputKeys.facultyId) !=
                                            null &&
                                        CheckOneTimeCodeForm.formGroup.getValue(
                                                AuthInputKeys.majorId) !=
                                            null) ||
                                    (AuthBloc.selectedRole == Role.superAdmin &&
                                        CheckOneTimeCodeForm.formGroup.getValue(
                                                AuthInputKeys.facultyId) !=
                                            null);

                                return Opacity(
                                  opacity: isFormReady ? 1.0 : 0.5,
                                  child: AuthButton.primary(
                                    height: 50.h,
                                    isLoading:
                                        state.checkOneTimeResult.isLoading(),
                                    title: AppStrings.checkYourAccessCode,
                                    onPressed: () {
                                      printR("isFormReady: $isFormReady");
                                      printR(
                                          "CheckOneTimeCodeForm.formGroup.isFormValid(): ${CheckOneTimeCodeForm.formGroup.isFormValid()}");

                                      // Check if faculty and major are selected for admin roles
                                      if (AuthBloc.selectedRole == Role.admin) {
                                        final facultyId = CheckOneTimeCodeForm
                                            .formGroup
                                            .getValue(AuthInputKeys.facultyId);
                                        final majorId = CheckOneTimeCodeForm
                                            .formGroup
                                            .getValue(AuthInputKeys.majorId);

                                        if (facultyId == null) {
                                          showErrorOverlay(context,
                                              '${AppStrings.selectFaculty} ${AppStrings.thisFieldRequired}');
                                          return;
                                        }

                                        if (majorId == null) {
                                          showErrorOverlay(context,
                                              '${AppStrings.selectMajor} ${AppStrings.thisFieldRequired}');
                                          return;
                                        }
                                      }

                                      // Check if faculty is selected for super admin role
                                      if (AuthBloc.selectedRole ==
                                          Role.superAdmin) {
                                        final facultyId = CheckOneTimeCodeForm
                                            .formGroup
                                            .getValue(AuthInputKeys.facultyId);

                                        if (facultyId == null) {
                                          showErrorOverlay(context,
                                              '${AppStrings.selectFaculty} ${AppStrings.thisFieldRequired}');
                                          return;
                                        }
                                      }

                                      // Check if form is valid
                                      if (!CheckOneTimeCodeForm.formGroup
                                          .isFormValid()) {
                                        showErrorOverlay(context,
                                            AppStrings.thisFieldRequired);
                                        return;
                                      }

                                      // If all validations pass, proceed with submission
                                      getIt<AuthBloc>().add(
                                        CheckOneTimeCodeEvent(
                                          checkOneTimeParam: CheckOneTimeParam(
                                            gmail: CheckOneTimeCodeForm
                                                .formGroup
                                                .getValue(
                                              AuthInputKeys.email,
                                            ),
                                            code: CheckOneTimeCodeForm.formGroup
                                                .getValue(
                                              AuthInputKeys.oneTimeCode,
                                            ),
                                            id: CheckOneTimeCodeForm.formGroup
                                                .getValue(
                                              AuthBloc.selectedRole ==
                                                      Role.admin
                                                  ? AuthInputKeys.majorId
                                                  : AuthInputKeys.facultyId,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    context: context,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleSpecificFields() {
    switch (AuthBloc.selectedRole) {
      case Role.admin:
        return const SizedBox.shrink(); // MajorSelector handles this
      case Role.superAdmin:
        return _superAdminFields();
      case Role.professor:
        return const SizedBox.shrink(); // No additional fields for professor
      case Role.systemController:
        return const SizedBox.shrink(); // System controller doesn't register
    }
  }

  Widget _superAdminFields() {
    return BlocConsumer<InfoBloc, InfoState>(
      listener: (context, state) {
        if (state.faculties.isError()) {
          showErrorOverlay(context, state.faculties.getError());
        }
      },
      builder: (context, state) {
        return ReactiveFormConsumer(builder: (context, form, child) {
          return Column(
            children: [
              // Only faculty selection for SuperAdmin using CustomPicker
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
            ],
          );
        });
      },
    );
  }

  Widget _userInfo() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      // Check if form is disabled (when faculty/major not selected for admin roles, or faculty not selected for super admin)
      final isFormDisabled = (AuthBloc.selectedRole == Role.admin &&
              (form.getValue(AuthInputKeys.facultyId) == null ||
                  form.getValue(AuthInputKeys.majorId) == null)) ||
          (AuthBloc.selectedRole == Role.superAdmin &&
              form.getValue(AuthInputKeys.facultyId) == null);

      return Column(
        children: [
          if (isFormDisabled &&
              (AuthBloc.selectedRole == Role.admin ||
                  AuthBloc.selectedRole == Role.superAdmin))
            Container(
              padding: REdgeInsets.all(12),
              margin: REdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: context.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: context.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.primaryColor,
                    size: 20.r,
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      AuthBloc.selectedRole == Role.admin
                          ? '${AppStrings.selectFaculty} ${AppStrings.selectMajor}'
                          : AppStrings.selectFaculty,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Opacity(
            opacity: isFormDisabled ? 0.5 : 1.0,
            child: Column(
              children: [
                CustomReactiveField(
                  controller: AuthInputKeys.email,
                  hintText: AppStrings.enterEmail,
                  title: AppStrings.email,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: isFormDisabled,
                ),
                10.verticalSpace,
                CustomReactiveField(
                  controller: AuthInputKeys.oneTimeCode,
                  hintText: AppStrings.enterOneTimeCode,
                  title: AppStrings.oneTimeCode,
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  readOnly: isFormDisabled,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
