import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/constants/app_constants.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/input_forms/subject_management_form.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/input_forms/subject_management_input_keys.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/ui/widgets/subject_management_body.dart';
import 'package:uni_sphere_admin/router/router_config.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/entities/major.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/extensions/form_extension.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/state/bloc/announcements_management_bloc.dart';

class SubjectManagementScreen extends StatefulWidget {
  const SubjectManagementScreen({super.key});

  static const String pagePath = 'subject_management';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey(
          'subject_management:${DateTime.now().millisecondsSinceEpoch}'),
      child: const SubjectManagementScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<SubjectManagementScreen> createState() =>
      _SubjectManagementScreenState();
}

class _SubjectManagementScreenState extends State<SubjectManagementScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  // Individual animations for each widget
  late Animation<double> _titleAnimation;
  late Animation<double> _formAnimation;
  late Animation<double> _bodyAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create staggered animations
    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack),
    ));

    _formAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
    ));

    _bodyAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
    ));

    // Start animations
    _fadeController.forward();
    _animationController.forward();
  }

  void _initializeData() {
    // Clear form when entering screen
    SubjectManagementForm.clearForm();

    // Fetch data based on role
    if (AppConstants.userRole == Role.superadmin) {
      getIt<InfoBloc>().add(GetSuperAdminMajorsEvent());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    SubjectManagementForm.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<InfoBloc>()),
        BlocProvider.value(value: getIt<GetSubjectsBloc>()),
      ],
      child: FadeTransition(
        opacity: _fadeController,
        child: ReactiveForm(
          key: ValueKey("subject_management_form"),
          formGroup: SubjectManagementForm.formGroup,
          child: CustomScaffoldBody(
            child: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalScreensPadding,
                ),
                child: Column(
                  key: ValueKey("subject_management_form_column"),
                  children: [
                    20.verticalSpace,
                    if (AppConstants.userRole == Role.superadmin) ...[
                      AnimatedBuilder(
                        animation: _titleAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 30 * (1 - _titleAnimation.value)),
                            child: Opacity(
                              opacity: _titleAnimation.value.clamp(0.0, 1.0),
                              child: Text(
                                AppStrings.selectFilters,
                                style: context.textTheme.titleLarge?.copyWith(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                      30.verticalSpace,
                    ],
                    AnimatedBuilder(
                      animation: _formAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(50 * (1 - _formAnimation.value), 0),
                          child: Opacity(
                            opacity: _formAnimation.value.clamp(0.0, 1.0),
                            child: _buildForm(context),
                          ),
                        );
                      },
                    ),
                    20.verticalSpace,
                    AnimatedBuilder(
                      animation: _bodyAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(-50 * (1 - _bodyAnimation.value), 0),
                          child: Opacity(
                            opacity: _bodyAnimation.value.clamp(0.0, 1.0),
                            child: const SubjectManagementBody(),
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

  Widget _buildForm(BuildContext context) {
    if (AppConstants.userRole == Role.professor) {
      return const SizedBox.shrink(); // Remove professor info section
    } else if (AppConstants.userRole == Role.superadmin) {
      return _buildSuperAdminForm(context);
    } else {
      return _buildDefaultForm(context);
    }
  }

  Widget _buildSuperAdminForm(BuildContext context) {
    return BlocConsumer<InfoBloc, InfoState>(
      listener: (context, state) {
        if (state.superAdminMajors.isError()) {
          showErrorOverlay(context, state.superAdminMajors.getError());
        }
      },
      builder: (context, state) {
        return ReactiveFormConsumer(builder: (context, form, child) {
          return Container(
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.superAdminView,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                16.verticalSpace,
                CustomPickerField(
                  formGroup: SubjectManagementForm.formGroup,
                  controller: SubjectManagementInputKeys.major,
                  data: state.superAdminMajors
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
                    form.setValue(SubjectManagementInputKeys.major, value);
                    form.setValue(SubjectManagementInputKeys.majorId, id);
                    // Clear year when major changes
                    form.setValue(SubjectManagementInputKeys.year, null);
                  },
                  selectedItem: DropDownData(
                    name: form.getValue(SubjectManagementInputKeys.major),
                    id: form.getValue(SubjectManagementInputKeys.majorId),
                  ),
                  enableSearch: true,
                  width: double.infinity,
                  isLoading: state.superAdminMajors.isLoading(),
                  readOnly: false,
                ),
                16.verticalSpace,
                _buildYearPicker(context, form),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildYearPicker(BuildContext context, FormGroup form) {
    final majorId = form.getValue(SubjectManagementInputKeys.majorId);
    final major = getIt<InfoBloc>()
        .state
        .superAdminMajors
        .getDataWhenSuccess()
        ?.firstWhere((m) => m.id == majorId,
            orElse: () => Major(id: '', name: '', numberOfYears: 0));

    if (major == null || major.id.isEmpty) {
      return Container(
        padding: REdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.greyColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: context.greyColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: context.greyColor,
              size: 20.r,
            ),
            8.horizontalSpace,
            Expanded(
              child: Text(
                AppStrings.selectMajorFirst,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.greyColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final selectedYear = form.getValue(SubjectManagementInputKeys.year);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectYear,
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.black,
            fontSize: 15.sp,
          ),
        ),
        8.verticalSpace,
        Container(
          width: double.infinity,
          height: 48.h,
          decoration: BoxDecoration(
            color: context.primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.greyColor.withValues(alpha: 0.5),
            ),
          ),
          child: DropdownButtonFormField<int>(
            value: selectedYear,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  REdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            hint: Text(AppStrings.selectYear),
            items: List.generate(major.numberOfYears, (index) {
              final year = index + 1;
              return DropdownMenuItem(
                value: year,
                child: Text('${AppStrings.year} $year'),
              );
            }),
            onChanged: (value) {
              form.setValue(SubjectManagementInputKeys.year, value);
              // Automatically fetch subjects when year is selected
              if (value != null) {
                getIt<GetSubjectsBloc>().add(GetSuperAdminSubjectsEvent(
                  majorId: majorId,
                  year: value,
                ));
                // Also refresh announcements for Admin role
                if (AppConstants.userRole == Role.admin) {
                  getIt<AnnouncementsManagementBloc>()
                      .add(GetAdminAnnouncementsEvent(year: value));
                }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultForm(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.noAccess,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.verticalSpace,
          Text(
            AppStrings.noAccessDescription,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
