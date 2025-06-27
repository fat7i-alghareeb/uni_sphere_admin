import 'dart:io' show File;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart' show Result;

import '../../../../../shared/entities/role.dart' show Role;
import '../../../../../shared/request_bodies/globel_patch_body.dart'
    show GlobalPatch, Patch;
import '../../../data/models/subjects_management_model.dart';
import '../../../data/params/update_param.dart' show UpdateParam;
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
    on<GetSubjectByIdEvent>(_getSubjectById);
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

  Future<void> _getSubjectById(
      GetSubjectByIdEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(getSubjectByIdResult: const Result.loading()));
    final result = await _usecase.getSubjectById(event.id, event.role);
    result.fold(
      (l) => emit(
        state.copyWith(getSubjectByIdResult: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(getSubjectByIdResult: Result.loaded(data: r)),
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
      (data) => emit(
        state.copyWith(
          getSubjectByIdResult: Result.loaded(data: data),
          operationResult: const Result.loaded(data: true),
        ),
      ),
    );
  }

  Future<void> _uploadMaterial(
      UploadMaterialEvent event, Emitter<SubjectState> emit) async {
    emit(state.copyWith(operationResult: const Result.loading()));
    final result = await _usecase.uploadMaterial(event.id, event.file);
    result.fold(
      (error) => emit(
        state.copyWith(operationResult: Result.error(error: error)),
      ),
      (data) => emit(
        state.copyWith(
          getSubjectByIdResult: Result.loaded(data: data),
          operationResult: const Result.loaded(data: true),
        ),
      ),
    );
  }
}
