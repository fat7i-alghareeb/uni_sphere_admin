// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:uni_sphere_admin/core/injection/src/access_injection.dart'
    show authInjection;
import 'package:uni_sphere_admin/core/injection/src/grade_management_injection.dart'
    show gradeManagementInjection;

// 🌎 Project imports:
import 'src/announcements_management_injection.dart';
import 'src/general_injection.dart';
import 'src/info_injection.dart';
import 'src/subjects_management_injection.dart';
import 'src/timetable_management_injection.dart';
import 'src/generate_otp_injection.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await generalInjection();
  await authInjection();
  await infoInjection();
  await subjectsManagementInjection();
  await timetableManagementInjection();
  await gradeManagementInjection();
  await generateOtpInjection();
  await announcementsManagementInjection();
}
