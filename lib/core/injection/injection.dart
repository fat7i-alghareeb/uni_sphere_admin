// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:uni_sphere_admin/core/injection/src/access_injection.dart'
    show authInjection;

// 🌎 Project imports:
import 'src/general_injection.dart';
import 'src/info_injection.dart';
import 'src/subjects_management_injection.dart';

final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
  await generalInjection();
  await authInjection();
  await infoInjection();
  await subjectsManagementInjection();
}
