import 'dart:async';
import 'package:beamer/beamer.dart';
import '../features/root/presentation/ui/screen/root_screen.dart';
import '../shared/imports/imports.dart';
import '../shared/states/app_manager_bloc/app_manager_bloc.dart';
import '../shared/utils/helper/colored_print.dart';

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
      initialPath: RootScreen.pagePath,
      updateListenable: RefreshStream(appManagerBloc.stream),
      routeListener: (routerInfo, routerDelegate) {
        printG("route: ${routerInfo.uri}");
        printC(appManagerBloc.state.status);

        // final bool isUpdateAvailable = appManagerBloc.state.expired == true;
        // final bool isInUpdate = routerInfo.location == UpdateAvailable.routePath;
        // if (isInUpdate && isUpdateAvailable) {
        //   return null;
        // }
        // if (isUpdateAvailable) {
        //   routerDelegate.beamToNamed(UpdateAvailable.routePath);
        // }
        // if (appManagerBloc.state.status == Status.authenticated && !routerInfo.location!.contains(RootScreen.pagePath)) {
        //   routerDelegate.beamToNamed(RootScreen.pagePath);
        // } else if (appManagerBloc.state.status == Status.unauthenticated && !routerInfo.location!.contains(LoginScreen.pagePath)) {
        //   routerDelegate.beamToNamed(LoginScreen.pagePath);
        // }
      },
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/root': RootScreen.pageBuilder,
        },
      ).call,
    );
  }
}
