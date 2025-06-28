
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../../../core/result_builder/result.dart' show Result;
import '../../../../generate_otp/data/param/subject_grade.dart' show SubjectGrade;
import '../../../domain/usecases/grade_management_usecase.dart' show GradeManagementUsecase;

part 'grade_management_event.dart';
part 'grade_management_state.dart';

class GradeManagementBloc extends Bloc<GradeManagementEvent, GradeManagementState> {
  final GradeManagementUsecase _usecase;

  GradeManagementBloc({
    required GradeManagementUsecase usecase,
  }) : _usecase = usecase, super(GradeManagementState()) {
    on<AssignGradesToSubjectEvent>(_onAssignGradesToSubject);
  }

  Future<void> _onAssignGradesToSubject(
      AssignGradesToSubjectEvent event, Emitter<GradeManagementState> emit) async {
    emit(state.copyWith(result: const Result.loading()));

    final response = await _usecase.assignGradesToSubject(event.subjectGrade);
    response.fold(
      (error) => emit(state.copyWith(result: Result.error(error: error))),
      (data) => emit(state.copyWith(result: Result.loaded(data: true))),
    );
  }
}
