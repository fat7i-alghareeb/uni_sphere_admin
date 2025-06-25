// import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
// import '../../../core/result_builder/result.dart';
// import '../../entities/faculty.dart' show Faculty;
// import '../../entities/major.dart' show Major;
// import '../../repo/info_repo.dart' show InfoRepo;

// part 'info_event.dart';
// part 'info_state.dart';

// class InfoBloc extends Bloc<InfoEvent, InfoState> {
//   final InfoRepo _infoRepo;
//   InfoBloc({required InfoRepo infoRepo})
//       : _infoRepo = infoRepo,
//         super(InfoState()) {
//     on<GetFacultiesEvent>(_getFaculties);
//     on<GetMajorsEvent>(_getMajors);
//   }

//   Future<void> _getFaculties(
//       GetFacultiesEvent event, Emitter<InfoState> emit) async {
//     if (state.faculties.isLoaded()) {
//       return;
//     }
//     emit(
//       state.copyWith(
//         faculties: const Result.loading(),
//       ),
//     );
//     final result = await _infoRepo.getFaculties();
//     result.fold(
//       (l) => emit(state.copyWith(faculties: Result.error(error: l))),
//       (r) => emit(state.copyWith(faculties: Result.loaded(data: r))),
//     );
//   }

//   Future<void> _getMajors(GetMajorsEvent event, Emitter<InfoState> emit) async {
//     emit(state.copyWith(majors: const Result.loading()));
//     final result = await _infoRepo.getMajors(facultyId: event.facultyId);
//     result.fold(
//       (l) => emit(state.copyWith(majors: Result.error(error: l))),
//       (r) => emit(state.copyWith(majors: Result.loaded(data: r))),
//     );
//   }
// }
