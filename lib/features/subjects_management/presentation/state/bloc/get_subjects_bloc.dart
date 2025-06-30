import 'dart:io' show File;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/core/constants/app_constants.dart';

import '../../../../../shared/entities/role.dart' show Role;
import '../../../../../shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch, Patch;
import '../../../data/models/subjects_management_model.dart'
    show
        FacultySubjects,
        Subject,
        UniversitySubjects,
        SuperAdminSubjects,
        MajorSubjects;
import '../../../data/params/update_param.dart' show UpdateSubjectParam;
import '../../../domain/usecases/subjects_management_usecase.dart'
    show SubjectsManagementUsecase;

part 'get_subjects_event.dart';
part 'get_subjects_state.dart';

class GetSubjectsBloc extends Bloc<GetSubjectsEvent, SubjectState> {
  final SubjectsManagementUsecase _usecase;

  GetSubjectsBloc({required SubjectsManagementUsecase usecase})
      : _usecase = usecase,
        super(SubjectState()) {
    on<GetSuperAdminSubjectsEvent>(_getSuperAdminSubjects);
    on<GetProfessorSubjectsEvent>(_getProfessorSubjects);
    on<UpdateSubjectEvent>(_updateSubject);
    on<UploadMaterialEvent>(_uploadMaterial);
  }

  Future<void> _getSuperAdminSubjects(
      GetSuperAdminSubjectsEvent event, Emitter<SubjectState> emit) async {
    emit(
      state.copyWith(
        getSuperAdminSubjectsResult: const Result.loading(),
      ),
    );
    final result = await _usecase.getSuperAdminSubjects(
        year: event.year, majorId: event.majorId);
    result.fold(
      (l) => emit(
        state.copyWith(
          getSuperAdminSubjectsResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          getSuperAdminSubjectsResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  Future<void> _getProfessorSubjects(
      GetProfessorSubjectsEvent event, Emitter<SubjectState> emit) async {
    emit(
      state.copyWith(
        getProfessorSubjectsResult: const Result.loading(),
      ),
    );
    final result = await _usecase.getProfessorSubjects();
    result.fold(
      (l) => emit(
        state.copyWith(
          getProfessorSubjectsResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          getProfessorSubjectsResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  Future<void> _updateSubject(
      UpdateSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));

    final result = await _usecase.updateSubject(
      event.id,
      GlobalPatch(
        patches: event.fields
            .map(
              (field) => Patch(
                  path: field.field.name,
                  op: 'replace',
                  from: "",
                  value: field.newValue),
            )
            .toList(),
      ),
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          operationResult: Result.error(error: error),
        ),
      ),
      (updatedSubject) {
        // Update the subject in the appropriate list based on user role
        if (AppConstants.userRole == Role.superadmin) {
          _updateSubjectInSuperAdminList(emit, updatedSubject);
        } else if (AppConstants.userRole == Role.professor) {
          _updateSubjectInProfessorList(emit, updatedSubject);
        }

        emit(
          state.copyWith(
            operationResult: const Result.loaded(data: true),
          ),
        );
      },
    );
  }

  Future<void> _uploadMaterial(
      UploadMaterialEvent event, Emitter<SubjectState> emit) async {
    // Validate that either file or url is provided, but not both
    if (event.file == null && event.url == null) {
      emit(
        state.copyWith(
          operationResult: const Result.error(
            error: "Please provide either a file or a link",
          ),
        ),
      );
      return;
    }

    if (event.file != null && event.url != null) {
      emit(
        state.copyWith(
          operationResult: const Result.error(
            error: "Please provide either a file or a link, not both",
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(operationResult: const Result.loading()));

    final result =
        await _usecase.uploadMaterial(event.id, event.file, event.url);

    result.fold(
      (error) => emit(
        state.copyWith(operationResult: Result.error(error: error)),
      ),
      (updatedSubject) {
        // Update the subject in the professor list (only professors can upload materials)
        _updateSubjectInProfessorList(emit, updatedSubject);

        emit(
          state.copyWith(
            operationResult: const Result.loaded(data: true),
          ),
        );
      },
    );
  }

  void _updateSubjectInSuperAdminList(
      Emitter<SubjectState> emit, Subject updatedSubject) {
    final currentResult = state.getSuperAdminSubjectsResult;
    if (currentResult.isLoaded()) {
      final currentData = currentResult.getDataWhenSuccess();
      if (currentData != null) {
        final updatedMajors = currentData.majors.map((major) {
          final updatedSubjects = major.subjects.map((subject) {
            return subject.id == updatedSubject.id ? updatedSubject : subject;
          }).toList();
          return MajorSubjects(
            majorName: major.majorName,
            subjects: updatedSubjects,
          );
        }).toList();

        final updatedData = SuperAdminSubjects(majors: updatedMajors);
        emit(
          state.copyWith(
            getSuperAdminSubjectsResult: Result.loaded(data: updatedData),
          ),
        );
      }
    }
  }

  void _updateSubjectInProfessorList(
      Emitter<SubjectState> emit, Subject updatedSubject) {
    final currentResult = state.getProfessorSubjectsResult;
    if (currentResult.isLoaded()) {
      final currentData = currentResult.getDataWhenSuccess();
      if (currentData != null) {
        final updatedFaculties = currentData.faculties.map((faculty) {
          final updatedMajors = faculty.majors.map((major) {
            final updatedSubjects = major.subjects.map((subject) {
              return subject.id == updatedSubject.id ? updatedSubject : subject;
            }).toList();
            return MajorSubjects(
              majorName: major.majorName,
              subjects: updatedSubjects,
            );
          }).toList();
          return FacultySubjects(
            facultyName: faculty.facultyName,
            majors: updatedMajors,
          );
        }).toList();

        final updatedData = UniversitySubjects(
          universityName: currentData.universityName,
          faculties: updatedFaculties,
        );
        emit(
          state.copyWith(
            getProfessorSubjectsResult: Result.loaded(data: updatedData),
          ),
        );
      }
    }
  }
}
