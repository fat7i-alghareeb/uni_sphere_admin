import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../domain/usecases/generate_otp_usecase.dart'
    show GenerateOtpUsecase;
import '../../../../../core/result_builder/result.dart' show Result;
import '../../../../grade_management/data/param/assign_one_time_code.dart'
    show AssignOneTimeCode;

part 'generate_otp_event.dart';
part 'generate_otp_state.dart';

class GenerateOtpBloc extends Bloc<GenerateOtpEvent, GenerateOtpState> {
  final GenerateOtpUsecase _usecase;

  GenerateOtpBloc({required GenerateOtpUsecase usecase})
      : _usecase = usecase,
        super(GenerateOtpState()) {
    on<AssignOneTimeCodeToStudentEvent>(_onAssignOneTimeCodeToStudent);
    on<AssignOneTimeCodeGeneralEvent>(_onAssignOneTimeCodeGeneral);
  }

  Future<void> _onAssignOneTimeCodeToStudent(
      AssignOneTimeCodeToStudentEvent event,
      Emitter<GenerateOtpState> emit) async {
    emit(state.copyWith(result: const Result.loading()));

    final response =
        await _usecase.assignOneTimeCodeToStudent(event.assignOneTimeCode);
    response.fold(
      (error) => emit(state.copyWith(result: Result.error(error: error))),
      (data) => emit(state.copyWith(result: Result.loaded(data: true))),
    );
  }

  Future<void> _onAssignOneTimeCodeGeneral(AssignOneTimeCodeGeneralEvent event,
      Emitter<GenerateOtpState> emit) async {
    emit(state.copyWith(result: const Result.loading()));

    final response =
        await _usecase.assignOneTimeCodeToProfessor(event.assignOneTimeCode);
    response.fold(
      (error) => emit(state.copyWith(result: Result.error(error: error))),
      (data) => emit(state.copyWith(result: Result.loaded(data: true))),
    );
  }
}
