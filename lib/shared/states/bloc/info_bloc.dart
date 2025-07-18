import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import '../../../core/result_builder/result.dart';
import '../../entities/admin.dart' show Admin;
import '../../entities/faculty.dart' show Faculty;
import '../../entities/major.dart' show Major;
import '../../entities/professor.dart' show Professor;
import '../../entities/student_info.dart' show StudentInfo;
import '../../entities/subject_info.dart' show SubjectInfo;
import '../../repo/info_repo.dart' show InfoRepo;

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final InfoRepo _infoRepo;
  InfoBloc({required InfoRepo infoRepo})
      : _infoRepo = infoRepo,
        super(InfoState()) {
    on<GetFacultiesEvent>(_getFaculties);
    on<GetMajorsEvent>(_getMajors);
    on<GetSuperAdminMajorsEvent>(_getSuperAdminMajors);
    on<GetMyMajorSubjectsEvent>(_getMyMajorSubjects);
    on<GetStudentForSubjectEvent>(_getStudentForSubject);
    on<GetProfessorsEvent>(_getProfessors);
    on<GetUnregisteredStudentsByMajorEvent>(_getUnregisteredStudentsByMajor);
    on<GetUnregisteredAdminsByFacultyEvent>(_getUnregisteredAdminsByFaculty);
    on<GetUnassignedSubjectsEvent>(_getUnassignedSubjects);
  }

  Future<void> _getFaculties(
      GetFacultiesEvent event, Emitter<InfoState> emit) async {
    if (state.faculties.isLoaded()) {
      return;
    }
    emit(
      state.copyWith(
        faculties: const Result.loading(),
      ),
    );
    final result = await _infoRepo.getFaculties();
    result.fold(
      (l) => emit(state.copyWith(faculties: Result.error(error: l))),
      (r) => emit(state.copyWith(faculties: Result.loaded(data: r))),
    );
  }

  Future<void> _getMajors(GetMajorsEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(majors: const Result.loading()));
    final result = await _infoRepo.getMajors(facultyId: event.facultyId);
    result.fold(
      (l) => emit(state.copyWith(majors: Result.error(error: l))),
      (r) => emit(state.copyWith(majors: Result.loaded(data: r))),
    );
  }

  Future<void> _getSuperAdminMajors(
      GetSuperAdminMajorsEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(superAdminMajors: const Result.loading()));
    final result = await _infoRepo.getSuperAdminMajors();
    result.fold(
      (l) => emit(state.copyWith(superAdminMajors: Result.error(error: l))),
      (r) => emit(state.copyWith(superAdminMajors: Result.loaded(data: r))),
    );
  }

  Future<void> _getMyMajorSubjects(
      GetMyMajorSubjectsEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(myMajorSubjects: const Result.loading()));
    final result = await _infoRepo.getMyMajorSubjects(year: event.year);
    result.fold(
      (l) => emit(state.copyWith(myMajorSubjects: Result.error(error: l))),
      (r) => emit(state.copyWith(myMajorSubjects: Result.loaded(data: r))),
    );
  }

  Future<void> _getStudentForSubject(
      GetStudentForSubjectEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(students: const Result.loading()));
    final result =
        await _infoRepo.getStudentForSubject(subjectId: event.subjectId);
    result.fold(
      (l) => emit(state.copyWith(students: Result.error(error: l))),
      (r) => emit(state.copyWith(students: Result.loaded(data: r))),
    );
  }

  Future<void> _getProfessors(
      GetProfessorsEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(professors: const Result.loading()));
    final result = await _infoRepo.getProfessors();
    result.fold(
      (l) => emit(state.copyWith(professors: Result.error(error: l))),
      (r) => emit(state.copyWith(professors: Result.loaded(data: r))),
    );
  }

  Future<void> _getUnregisteredStudentsByMajor(
      GetUnregisteredStudentsByMajorEvent event,
      Emitter<InfoState> emit) async {
    emit(state.copyWith(unregisteredStudent: const Result.loading()));
    final result = await _infoRepo.getUnregisteredStudentsByMajor(
        studentNumber: event.studentNumber);
    result.fold(
      (l) => emit(state.copyWith(unregisteredStudent: Result.error(error: l))),
      (r) => emit(state.copyWith(unregisteredStudent: Result.loaded(data: r))),
    );
  }

  Future<void> _getUnregisteredAdminsByFaculty(
      GetUnregisteredAdminsByFacultyEvent event,
      Emitter<InfoState> emit) async {
    emit(state.copyWith(admins: const Result.loading()));
    final result = await _infoRepo.getUnregisteredAdminsByFaculty();
    result.fold(
      (l) => emit(state.copyWith(admins: Result.error(error: l))),
      (r) => emit(state.copyWith(admins: Result.loaded(data: r))),
    );
  }

  Future<void> _getUnassignedSubjects(
      GetUnassignedSubjectsEvent event, Emitter<InfoState> emit) async {
    emit(state.copyWith(unassignedSubjects: const Result.loading()));
    final result = await _infoRepo.getUnassignedSubjects(
        majorId: event.majorId, majorYear: event.majorYear);
    result.fold(
      (l) => emit(state.copyWith(unassignedSubjects: Result.error(error: l))),
      (r) => emit(state.copyWith(unassignedSubjects: Result.loaded(data: r))),
    );
  }
}
