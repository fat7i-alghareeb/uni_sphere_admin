import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart' show Status;

import '../features/root/presentation/ui/screen/root_screen.dart'
    show RootScreen;
import '../shared/imports/imports.dart';
import '../shared/states/app_manager_bloc/app_manager_bloc.dart';
import '../shared/utils/helper/colored_print.dart';
import '../features/access/presentation/ui/screens/role_selection_screen.dart'
    show RoleSelectionScreen;
import '../features/access/presentation/ui/screens/authentication_method_screen.dart'
    show AuthenticationMethodScreen;
import '../features/access/presentation/ui/screens/login_screen.dart'
    show LoginScreen;
import '../features/access/presentation/ui/screens/check_one_time_code_screen.dart'
    show CheckOneTimeCodeScreen;
import '../features/access/presentation/ui/screens/register_screen.dart'
    show RegisterScreen;

typedef BeamerBuilder = dynamic Function(BuildContext, BeamState, Object?);

class RefreshStream extends ChangeNotifier {
  RefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class BRouterConfig {
  late final AppManagerBloc appManagerBloc;
  late final BeamerDelegate router;

  BRouterConfig({required this.appManagerBloc}) {
    router = BeamerDelegate(
      initialPath: RoleSelectionScreen.pagePath,
      updateListenable: RefreshStream(appManagerBloc.stream),
      routeListener: (routerInfo, routerDelegate) {
        printG("route: ${routerInfo.uri}");
        printC(appManagerBloc.state.status);

        if (appManagerBloc.state.status == Status.authenticated &&
            !routerInfo.uri.path.contains(RootScreen.pagePath)) {
          routerDelegate.beamToReplacementNamed(RootScreen.pagePath);
        } else if (appManagerBloc.state.status == Status.unauthenticated &&
            !routerInfo.uri.path.contains(RoleSelectionScreen.pagePath)) {
          routerDelegate.beamToReplacementNamed(RoleSelectionScreen.pagePath);
        }
      },
      locationBuilder: RoutesLocationBuilder(
        routes: {
          //! -------------- Access ---------------- !//
          '/role_selection': RoleSelectionScreen.pageBuilder,
          '/role_selection/authentication_method':
              AuthenticationMethodScreen.pageBuilder,
          '/role_selection/authentication_method/login':
              LoginScreen.pageBuilder,
          '/role_selection/authentication_method/check_one_time_code':
              CheckOneTimeCodeScreen.pageBuilder,
          '/role_selection/authentication_method/check_one_time_code/register':
              RegisterScreen.pageBuilder,

          //! -------------- End Access ---------------- !//

          '/root': RootScreen.pageBuilder,
          // //! -------------- Subjects ---------------- !//
          // "/root/choose_years_screen": ChooseYearsScreen.pageBuilder,
          // "/root/subject_details": SubjectDetailsScreen.pageBuilder,
          // "/root/choose_years_screen/year_subjects": YearSubjects.pageBuilder,
          // "/root/choose_years_screen/year_subjects/subject_details":
          //     SubjectDetailsScreen.pageBuilder,
          // //! -------------- Announcements ---------------- !//
          // "/root/news_details": NewsDetailsScreen.pageBuilder,
          // //! -------------- Settings ---------------- !//
          // "/root/language_selection": LanguageSelectionScreen.pageBuilder,
          // "/root/grades_screen": GradesScreen.pageBuilder,
          // "/root/student": StudentScreen.pageBuilder,
        },
      ).call,
    );
  }
}
