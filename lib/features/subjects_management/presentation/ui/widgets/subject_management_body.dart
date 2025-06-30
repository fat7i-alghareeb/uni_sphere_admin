import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/input_forms/subject_management_input_keys.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/extensions/form_extension.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import 'package:uni_sphere_admin/shared/widgets/failed_widget.dart';
import 'subject_item_card.dart';

class SubjectManagementBody extends StatefulWidget {
  const SubjectManagementBody({super.key});

  @override
  State<SubjectManagementBody> createState() => _SubjectManagementBodyState();
}

class _SubjectManagementBodyState extends State<SubjectManagementBody> {
  late final GetSubjectsBloc _subjectsBloc;
  bool _hasFetchedForProfessor = false;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = getIt<GetSubjectsBloc>();

    // Automatically fetch subjects for professor IMMEDIATELY
    if (AppConstants.userRole == Role.professor) {
      _subjectsBloc.add(GetProfessorSubjectsEvent());
      _hasFetchedForProfessor = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return BlocConsumer<GetSubjectsBloc, SubjectState>(
          listener: (context, state) {
            if (AppConstants.userRole == Role.superadmin) {
              if (state.getSuperAdminSubjectsResult.isError()) {
                showErrorOverlay(
                    context, state.getSuperAdminSubjectsResult.getError());
              }
            } else if (AppConstants.userRole == Role.professor) {
              if (state.getProfessorSubjectsResult.isError()) {
                showErrorOverlay(
                    context, state.getProfessorSubjectsResult.getError());
              }
            }
          },
          builder: (context, state) {
            return _buildContent(context, state, form);
          },
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, SubjectState state, FormGroup form) {
    if (AppConstants.userRole == Role.superadmin) {
      final isFormReady = _isSuperAdminFormReady(form);

      if (!isFormReady) {
        return _buildSuperAdminPlaceholder(context, form);
      }

      // Don't automatically fetch here - let the year picker handle it
      return _buildSuperAdminContent(context, state);
    } else if (AppConstants.userRole == Role.professor) {
      // For professor, show content immediately

      // Fallback: if not fetched yet, fetch now
      if (!_hasFetchedForProfessor) {
        _subjectsBloc.add(GetProfessorSubjectsEvent());
        _hasFetchedForProfessor = true;
      }

      return _buildProfessorContent(context, state);
    } else {
      return _buildNoAccessContent(context);
    }
  }

  void _fetchSuperAdminSubjects(FormGroup form) {
    final majorId = form.getValue(SubjectManagementInputKeys.majorId);
    final year = form.getValue(SubjectManagementInputKeys.year);
    if (majorId != null && year != null) {
      _subjectsBloc.add(GetSuperAdminSubjectsEvent(
        majorId: majorId,
        year: year,
      ));
    }
  }

  Widget _buildSuperAdminContent(BuildContext context, SubjectState state) {
    final subjectsResult = state.getSuperAdminSubjectsResult;

    if (subjectsResult.isLoading()) {
      return _buildLoadingState(context);
    }

    if (subjectsResult.isError()) {
      return _buildErrorState(context, subjectsResult.getError());
    }

    final superAdminSubjects = subjectsResult.getDataWhenSuccess();
    if (superAdminSubjects == null) {
      return _buildEmptyState(context);
    }

    return _buildSuperAdminSubjectsList(context, superAdminSubjects);
  }

  Widget _buildSuperAdminSubjectsList(
      BuildContext context, SuperAdminSubjects superAdminSubjects) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: superAdminSubjects.majors.length,
      itemBuilder: (context, index) {
        final major = superAdminSubjects.majors[index];
        return _buildMajorExpansionTile(context, major);
      },
    );
  }

  Widget _buildProfessorContent(BuildContext context, SubjectState state) {
    final subjectsResult = state.getProfessorSubjectsResult;

    if (subjectsResult.isLoading()) {
      return _buildLoadingState(context);
    }

    if (subjectsResult.isError()) {
      return _buildErrorState(context, subjectsResult.getError());
    }

    final universitySubjects = subjectsResult.getDataWhenSuccess();
    if (universitySubjects == null) {
      return _buildEmptyState(context);
    }

    return _buildUniversitySubjectsList(context, [universitySubjects]);
  }

  Widget _buildFacultySubjectsList(
      BuildContext context, FacultySubjects facultySubjects) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: facultySubjects.majors.length,
      itemBuilder: (context, index) {
        final major = facultySubjects.majors[index];
        return _buildMajorExpansionTile(context, major);
      },
    );
  }

  Widget _buildUniversitySubjectsList(
      BuildContext context, List<UniversitySubjects> universitySubjects) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: universitySubjects.length,
      itemBuilder: (context, index) {
        final universitySubject = universitySubjects[index];
        return _buildUniversityExpansionTile(context, universitySubject);
      },
    );
  }

  Widget _buildUniversityExpansionTile(
      BuildContext context, UniversitySubjects universitySubject) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        backgroundColor: context.cardColor,
        collapsedBackgroundColor: context.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          universitySubject.universityName,
          style: context.textTheme.titleLarge!.withColor(context.primaryColor),
        ),
        children: universitySubject.faculties.map((faculty) {
          return ExpansionTile(
            title: Text(
              faculty.facultyName,
              style: context.textTheme.titleMedium!
                  .withColor(context.primaryColor),
            ),
            children: faculty.majors.map((major) {
              return ExpansionTile(
                title: Text(
                  major.majorName,
                  style: context.textTheme.titleSmall!
                      .withColor(context.onBackgroundColor),
                ),
                children: major.subjects.map((subject) {
                  return Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: SubjectItemCard(
                      subject: subject,
                      showOnlyNameAndImage: true,
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMajorExpansionTile(BuildContext context, MajorSubjects major) {
    return Padding(
      padding: REdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: false,
          backgroundColor: context.backgroundColor,
          collapsedBackgroundColor: context.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            major.majorName,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            Padding(
              padding: REdgeInsets.only(
                left: 8.w,
                right: 8.w,
                bottom: 8.h,
              ),
              child: Column(
                children: major.subjects
                    .map((subject) => Padding(
                          padding: REdgeInsets.only(bottom: 4.h),
                          child: SubjectItemCard(
                            subject: subject,
                            showOnlyNameAndImage: true,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: context.primaryColor,
          ),
          16.verticalSpace,
          Text(
            AppStrings.loading,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.onBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return FailedWidget(
      error: error,
      onPressed: () {
        if (AppConstants.userRole == Role.superadmin) {
          _subjectsBloc.add(GetSuperAdminSubjectsEvent(
            year: 1, // This should be dynamic based on form
            majorId: '', // This should be dynamic based on form
          ));
        } else if (AppConstants.userRole == Role.professor) {
          _subjectsBloc.add(GetProfessorSubjectsEvent());
        }
      },
      retryText: AppStrings.tryAgain,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64.r,
            color: context.primaryColor.withValues(alpha: 0.5),
          ),
          16.verticalSpace,
          Text(
            AppStrings.noSubjectsAvailable,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.onBackgroundColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  bool _isSuperAdminFormReady(FormGroup form) {
    final majorId = form.getValue(SubjectManagementInputKeys.majorId);
    final year = form.getValue(SubjectManagementInputKeys.year);
    return majorId != null && year != null;
  }

  Widget _buildSuperAdminPlaceholder(BuildContext context, FormGroup form) {
    String message;
    final majorId = form.getValue(SubjectManagementInputKeys.majorId);
    if (majorId == null) {
      message = AppStrings.pleaseSelectMajorAndYear;
    } else {
      message = AppStrings.pleaseSelectYear;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64.r,
            color: context.primaryColor.withValues(alpha: 0.5),
          ),
          16.verticalSpace,
          Text(
            message,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.onBackgroundColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoAccessContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64.r,
            color: context.primaryColor.withValues(alpha: 0.5),
          ),
          16.verticalSpace,
          Text(
            AppStrings.noAccessDescription,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.onBackgroundColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
