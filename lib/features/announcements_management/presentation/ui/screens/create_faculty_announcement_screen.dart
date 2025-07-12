import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/announcements_management/data/params/create_faculty_announcement_param.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/input_forms/faculty_announcement_form.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/input_forms/announcement_creation_input_keys.dart';
import 'package:uni_sphere_admin/features/announcements_management/presentation/state/bloc/announcements_management_bloc.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';

import '../../../../../router/router_config.dart';

class CreateFacultyAnnouncementScreen extends StatefulWidget {
  const CreateFacultyAnnouncementScreen({super.key});

  static const String pagePath = 'create_faculty_announcement';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: const ValueKey('create_faculty_announcement'),
      child: const CreateFacultyAnnouncementScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<CreateFacultyAnnouncementScreen> createState() =>
      _CreateFacultyAnnouncementScreenState();
}

class _CreateFacultyAnnouncementScreenState
    extends State<CreateFacultyAnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    FacultyAnnouncementForm.clear();
  }

  @override
  void dispose() {
    FacultyAnnouncementForm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: getIt<AnnouncementsManagementBloc>(),
        child: ReactiveForm(
          formGroup: FacultyAnnouncementForm.formGroup,
          child: CustomScaffoldBody(
            title: AppStrings.createFacultyAnnouncement,
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
                  FacultyAnnouncementForm.clear();
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
                return SingleChildScrollView(
                  padding: REdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalScreensPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.verticalSpace,
                      CustomReactiveField(
                        controller: AnnouncementCreationInputKeys.titleEn,
                        title: AppStrings.announcementTitleEn,
                        hintText: AppStrings.enterAnnouncementTitleEn,
                        keyboardType: TextInputType.text,
                      ),
                      16.verticalSpace,
                      CustomReactiveField(
                        controller: AnnouncementCreationInputKeys.titleAr,
                        title: AppStrings.announcementTitleAr,
                        hintText: AppStrings.enterAnnouncementTitleAr,
                        keyboardType: TextInputType.text,
                      ),
                      16.verticalSpace,
                      CustomReactiveField(
                        controller: AnnouncementCreationInputKeys.contentEn,
                        title: AppStrings.announcementContentEn,
                        hintText: AppStrings.enterAnnouncementContentEn,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      16.verticalSpace,
                      CustomReactiveField(
                        controller: AnnouncementCreationInputKeys.contentAr,
                        title: AppStrings.announcementContentAr,
                        hintText: AppStrings.enterAnnouncementContentAr,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      24.verticalSpace,
                      AuthButton.primary(
                        title: AppStrings.createAnnouncement,
                        isLoading: state.createAnnouncementResult.isLoading(),
                        onPressed: () {
                          if (FacultyAnnouncementForm.formGroup.valid) {
                            final param = CreateFacultyAnnouncementParam(
                              titleEn: FacultyAnnouncementForm.formGroup
                                  .control(
                                      AnnouncementCreationInputKeys.titleEn)
                                  .value,
                              titleAr: FacultyAnnouncementForm.formGroup
                                  .control(
                                      AnnouncementCreationInputKeys.titleAr)
                                  .value,
                              contentEn: FacultyAnnouncementForm.formGroup
                                  .control(
                                      AnnouncementCreationInputKeys.contentEn)
                                  .value,
                              contentAr: FacultyAnnouncementForm.formGroup
                                  .control(
                                      AnnouncementCreationInputKeys.contentAr)
                                  .value,
                              images: [], // Empty list for now
                            );
                            context.read<AnnouncementsManagementBloc>().add(
                                  CreateFacultyAnnouncementEvent(param: param),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppStrings.thisFieldRequired),
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
            ),
          ),
        ),
      ),
    );
  }
}
