// Reminder: Make sure you have image_picker in your pubspec.yaml and run flutter pub get
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
        FacultyAnnouncementForm.formGroup
            .control(AnnouncementCreationInputKeys.images)
            .value = images;
      });
    }
  }

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

  Widget _buildImageGrid() {
    final images = _selectedImages;
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...images.asMap().entries.map((entry) {
            final idx = entry.key;
            final img = entry.value;
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  margin: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(img.path),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImages.removeAt(idx);
                        FacultyAnnouncementForm.formGroup
                            .control(AnnouncementCreationInputKeys.images)
                            .value = List<XFile>.from(_selectedImages);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            );
          }),
          // Add button
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child:
                  const Icon(Icons.add_a_photo, size: 32, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
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
                  setState(() {
                    _selectedImages = [];
                  });
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
                      16.verticalSpace,
                      Text('Images'),
                      _buildImageGrid(),
                      24.verticalSpace,
                      AuthButton.primary(
                        title: AppStrings.createAnnouncement,
                        isLoading: state.createAnnouncementResult.isLoading(),
                        onPressed: () {
                          if (FacultyAnnouncementForm.formGroup.valid) {
                            final images = (FacultyAnnouncementForm.formGroup
                                        .control(AnnouncementCreationInputKeys
                                            .images)
                                        .value as List<XFile>?)
                                    ?.map((xfile) => File(xfile.path))
                                    .toList() ??
                                [];
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
                              images: images,
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
