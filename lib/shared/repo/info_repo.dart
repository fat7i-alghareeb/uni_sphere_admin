// import 'package:fpdart/fpdart.dart' show Either;
// import '../entities/faculty.dart' show Faculty;
// import '../remote/info_remote.dart' show InfoRemote;
// import 'package:test/shared/services/exception/error_handler.dart'
//     show throwAppException;

// import '../entities/major.dart' show Major;

// class InfoRepo {
//   final InfoRemote _infoRemote;

//   InfoRepo({required InfoRemote infoRemote}) : _infoRemote = infoRemote;

//   Future<Either<String, List<Faculty>>> getFaculties() async {
//     return await throwAppException(
//       () async {
//         return await _infoRemote.getFaculties();
//       },
//     );
//   }

//   Future<Either<String, List<Major>>> getMajors(
//       {required String facultyId}) async {
//     return await throwAppException(
//       () async {
//         return await _infoRemote.getMajors(facultyId: facultyId);
//       },
//     );
//   }
// }
