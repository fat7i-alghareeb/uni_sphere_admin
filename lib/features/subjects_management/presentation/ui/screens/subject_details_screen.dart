import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/subjects_management/data/models/subjects_management_model.dart';
import 'package:uni_sphere_admin/features/subjects_management/presentation/state/bloc/get_subjects_bloc.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import '../../../../../router/router_config.dart';
import '../widgets/subject_details_header.dart';
import '../widgets/subject_details_grades.dart';
import '../widgets/subject_details_materials.dart';
import '../widgets/subject_details_image.dart';
import '../widgets/subject_details_update.dart';

class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({
    super.key,
    required this.subject,
  });

  final Subject subject;
  static const String pagePath = 'subject_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final subject = data as Subject;
    return BeamPage(
      key: ValueKey('subject_details_${subject.id}'),
      child: SubjectDetailsScreen(subject: subject),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;
  bool _hasAnimated = false;
  late Subject _currentSubject;

  @override
  void initState() {
    super.initState();
    _currentSubject = widget.subject;
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(
      4, // Header, Grades, Materials, and Body
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * (0.5 / 4),
            (index * (0.5 / 4)) + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    try {
      _controller.dispose();
    } catch (e) {
      debugPrint('Error disposing animation controller: $e');
    }
    super.dispose();
  }

  void _handleSubjectUpdated() {
    // Refresh the subject data based on user role
    if (AppConstants.userRole == Role.superadmin) {
      // For SuperAdmin, we need to refresh the subjects list
      // The bloc will update the subject in the list automatically
      setState(() {
        // The bloc has already updated the subject in memory
        // We just need to trigger a rebuild
      });
    } else if (AppConstants.userRole == Role.professor) {
      // For Professor, refresh the subjects list
      getIt<GetSubjectsBloc>().add(GetProfessorSubjectsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<GetSubjectsBloc>(),
      child: BlocConsumer<GetSubjectsBloc, SubjectState>(
        listenWhen: (previous, current) =>
            previous.operationResult != current.operationResult,
        listener: (context, state) {
          if (state.operationResult.isError()) {
            showErrorOverlay(context, state.operationResult.getError());
          }
          if (state.operationResult.isLoaded()) {
            // Update the current subject with the latest data
            if (AppConstants.userRole == Role.superadmin) {
              final superAdminResult = state.getSuperAdminSubjectsResult;
              if (superAdminResult.isLoaded()) {
                final updatedSubject =
                    _findUpdatedSubject(superAdminResult.getDataWhenSuccess());
                if (updatedSubject != null) {
                  setState(() {
                    _currentSubject = updatedSubject;
                  });
                }
              }
            } else if (AppConstants.userRole == Role.professor) {
              final professorResult = state.getProfessorSubjectsResult;
              if (professorResult.isLoaded()) {
                final updatedSubject =
                    _findUpdatedSubject(professorResult.getDataWhenSuccess());
                if (updatedSubject != null) {
                  setState(() {
                    _currentSubject = updatedSubject;
                  });
                }
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SubjectDetailsImage(
                  imageUrl: _currentSubject.image,
                  title: _currentSubject.name,
                ),
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animations[0],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -20 * (1 - _animations[0].value)),
                        child: Opacity(
                          opacity: _animations[0].value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: REdgeInsets.symmetric(vertical: 9),
                      child: Column(
                        children: [
                          SubjectDetailsHeader(subject: _currentSubject),
                          SubjectDetailsUpdate(
                            subject: _currentSubject,
                            onSubjectUpdated: _handleSubjectUpdated,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_currentSubject.midtermGrade > 0 ||
                    _currentSubject.finalGrade > 0)
                  SliverToBoxAdapter(
                    child: AnimatedBuilder(
                      animation: _animations[1],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -20 * (1 - _animations[1].value)),
                          child: Opacity(
                            opacity: _animations[1].value,
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: REdgeInsets.symmetric(vertical: 9.0),
                        child: SubjectDetailsGrades(subject: _currentSubject),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: AnimatedBuilder(
                    animation: _animations[2],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -20 * (1 - _animations[2].value)),
                        child: Opacity(
                          opacity: _animations[2].value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: REdgeInsets.symmetric(vertical: 9.0),
                      child: SubjectDetailsMaterials(
                        subject: _currentSubject,
                        onMaterialUploaded: () {
                          // Refresh the subject data
                          if (AppConstants.userRole == Role.professor) {
                            getIt<GetSubjectsBloc>()
                                .add(GetProfessorSubjectsEvent());
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Subject? _findUpdatedSubject(dynamic data) {
    if (data == null) return null;

    if (AppConstants.userRole == Role.superadmin) {
      final superAdminData = data as SuperAdminSubjects;
      for (final major in superAdminData.majors) {
        for (final subject in major.subjects) {
          if (subject.id == widget.subject.id) {
            return subject;
          }
        }
      }
    } else if (AppConstants.userRole == Role.professor) {
      final professorData = data as UniversitySubjects;
      for (final faculty in professorData.faculties) {
        for (final major in faculty.majors) {
          for (final subject in major.subjects) {
            if (subject.id == widget.subject.id) {
              return subject;
            }
          }
        }
      }
    }

    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasAnimated && !_isDisposed) {
      _controller.forward();
      _hasAnimated = true;
    }
  }
}
