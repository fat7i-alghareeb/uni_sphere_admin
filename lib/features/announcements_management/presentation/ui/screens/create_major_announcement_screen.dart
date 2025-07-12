import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/announcements_management/data/params/create_major_announcement_param.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/input_forms/major_announcement_form.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/input_forms/announcement_creation_input_keys.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/state/bloc/announcements_management_bloc.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';

import '../../../../../router/router_config.dart';

class CreateMajorAnnouncementScreen extends StatefulWidget {
  const CreateMajorAnnouncementScreen({
    super.key,
    this.selectedYear = 1, // Default to year 1 if not provided
  });

  final int selectedYear;
  static const String pagePath = 'create_major_announcement';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final year = data as int? ?? 1; // Extract year from passed data
    return BeamPage(
      key: ValueKey('create_major_announcement_$year'),
      child: CreateMajorAnnouncementScreen(selectedYear: year),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<CreateMajorAnnouncementScreen> createState() =>
      _CreateMajorAnnouncementScreenState();
}

class _CreateMajorAnnouncementScreenState
    extends State<CreateMajorAnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    MajorAnnouncementForm.clear();
    // Load admin's major subjects
    getIt<InfoBloc>().add(GetMyMajorSubjectsEvent(year: widget.selectedYear));
  }

  @override
  void dispose() {
    MajorAnnouncementForm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AnnouncementsManagementBloc>()),
          BlocProvider.value(value: getIt<InfoBloc>()),
        ],
        child: ReactiveForm(
          formGroup: MajorAnnouncementForm.formGroup,
          child: CustomScaffoldBody(
            title: AppStrings.createMajorAnnouncement,
            child: BlocConsumer<AnnouncementsManagementBloc,
                AnnouncementsManagementState>(
              listener: (context, state) {
                if (state.createAnnouncementResult.isLoaded()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppStrings.announcementCreatedSuccess),
                      backgroundColor: Colors.green,
                    ),
                  );
                  MajorAnnouncementForm.clear();
                  context.beamBack();
                } else if (state.createAnnouncementResult.isError()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.createAnnouncementResult.getError()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return BlocBuilder<InfoBloc, InfoState>(
                  builder: (context, infoState) {
                    final subjects = infoState.myMajorSubjects
                            .getDataWhenSuccess()
                            ?.map((s) => DropDownData(id: s.id, name: s.name))
                            .toList() ??
                        [];

                    return ReactiveFormConsumer(
                      builder: (context, form, child) {
                        // Find the selected subject name from the subjects list
                        final selectedSubjectId = form
                            .control(AnnouncementCreationInputKeys.subjectId)
                            .value as String?;
                        final selectedSubject = subjects.firstWhere(
                          (subject) => subject.id == selectedSubjectId,
                          orElse: () => DropDownData(id: '', name: ''),
                        );

                        return SingleChildScrollView(
                          padding: REdgeInsets.symmetric(
                            horizontal: AppConstants.horizontalScreensPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              // Year Display
                              Container(
                                padding: REdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.primaryColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: context.primaryColor
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: context.primaryColor,
                                      size: 20.r,
                                    ),
                                    12.horizontalSpace,
                                    Expanded(
                                      child: Text(
                                        '${AppStrings.year} ${widget.selectedYear}',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: context.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              16.verticalSpace,
                              // Subject Selection
                              CustomPickerField(
                                formGroup: MajorAnnouncementForm.formGroup,
                                controller:
                                    AnnouncementCreationInputKeys.subjectId,
                                data: subjects,
                                hintText:
                                    AppStrings.selectSubjectForAnnouncement,
                                title: AppStrings.selectSubjectForAnnouncement,
                                onSelect: (value, id) {
                                  form
                                      .control(AnnouncementCreationInputKeys
                                          .subjectId)
                                      .value = id;
                                },
                                selectedItem: selectedSubjectId != null &&
                                        selectedSubjectId.isNotEmpty
                                    ? selectedSubject
                                    : null,
                                enableSearch: true,
                                width: double.infinity,
                                isLoading:
                                    infoState.myMajorSubjects.isLoading(),
                                readOnly: false,
                              ),
                              16.verticalSpace,
                              CustomReactiveField(
                                controller:
                                    AnnouncementCreationInputKeys.titleEn,
                                title: AppStrings.announcementTitleEn,
                                hintText: AppStrings.enterAnnouncementTitleEn,
                                keyboardType: TextInputType.text,
                              ),
                              16.verticalSpace,
                              CustomReactiveField(
                                controller:
                                    AnnouncementCreationInputKeys.titleAr,
                                title: AppStrings.announcementTitleAr,
                                hintText: AppStrings.enterAnnouncementTitleAr,
                                keyboardType: TextInputType.text,
                              ),
                              16.verticalSpace,
                              CustomReactiveField(
                                controller:
                                    AnnouncementCreationInputKeys.contentEn,
                                title: AppStrings.announcementContentEn,
                                hintText: AppStrings.enterAnnouncementContentEn,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                              ),
                              16.verticalSpace,
                              CustomReactiveField(
                                controller:
                                    AnnouncementCreationInputKeys.contentAr,
                                title: AppStrings.announcementContentAr,
                                hintText: AppStrings.enterAnnouncementContentAr,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                              ),
                              24.verticalSpace,
                              AuthButton.primary(
                                title: AppStrings.createAnnouncement,
                                isLoading:
                                    state.createAnnouncementResult.isLoading(),
                                onPressed: () {
                                  if (MajorAnnouncementForm.formGroup.valid) {
                                    final param = CreateMajorAnnouncementParam(
                                      subjectId: MajorAnnouncementForm.formGroup
                                          .control(AnnouncementCreationInputKeys
                                              .subjectId)
                                          .value,
                                      titleEn: MajorAnnouncementForm.formGroup
                                          .control(AnnouncementCreationInputKeys
                                              .titleEn)
                                          .value,
                                      titleAr: MajorAnnouncementForm.formGroup
                                          .control(AnnouncementCreationInputKeys
                                              .titleAr)
                                          .value,
                                      contentEn: MajorAnnouncementForm.formGroup
                                          .control(AnnouncementCreationInputKeys
                                              .contentEn)
                                          .value,
                                      contentAr: MajorAnnouncementForm.formGroup
                                          .control(AnnouncementCreationInputKeys
                                              .contentAr)
                                          .value,
                                    );
                                    context
                                        .read<AnnouncementsManagementBloc>()
                                        .add(
                                          CreateMajorAnnouncementEvent(
                                              param: param),
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text(AppStrings.thisFieldRequired),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                context: context,
                              ),
                              24.verticalSpace,
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
