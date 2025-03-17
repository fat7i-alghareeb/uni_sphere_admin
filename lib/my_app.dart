import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/styles/themes.dart';

import 'core/injection/injection.dart';
import 'core/styles/style.dart';
import 'features/root/presentation/state/provider/nav_bar_provider.dart';
import 'router/router_config.dart';
import 'shared/helper/localization_service.dart';
import 'shared/imports/imports.dart';
import 'core/repo/auth_repo/auth_repo.dart';
import 'shared/states/app_manager_bloc/app_manager_bloc.dart';
import 'shared/states/theme_provider/theme_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final BRouterConfig router;
  late final AppManagerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AppManagerBloc(
      doBeforeOpen: _doBeforeOpen,
      lazyAuthRepository: () => getIt<AuthRepository>(),
      context: context,
    )..add(AppManagerStarted());
    router = BRouterConfig(appManagerBloc: _bloc);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white.withOpacity(0.9),
      ),
      child: ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiProvider(
            providers: [
              BlocProvider.value(value: _bloc),
              ChangeNotifierProvider(
                create: (context) => NavBarProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ThemeProvider(),
              ),
            ],
            child: BeamerProvider(
                routerDelegate: router.router,
                child: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) =>
                      MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routerDelegate: router.router,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    theme: themeProvider.isDarkMode
                        ? AppThemes.darkThemeData()
                        : AppThemes.lightThemeData(),
                    routeInformationParser: BeamerParser(),
                    builder: (context, child) {
                      if (kReleaseMode) {
                        if (!getIt.isRegistered<LocalizationService>()) {
                          getIt.registerSingleton<LocalizationService>(
                            LocalizationService(context),
                          );
                        }
                      } else {
                        if (!getIt.isRegistered<LocalizationService>()) {
                          getIt.registerSingleton<LocalizationService>(
                            LocalizationService(context),
                          );
                        }
                        child = DevicePreview.appBuilder(context, child);
                      }
                      return child!;
                    },
                  ),
                )),
          );
        },
      ),
    );
  }

  FutureOr<void> _doBeforeOpen() async {
    final Completer<void> completer = Completer();
    try {
      // CheckVersion checkVersion = CheckVersion();
      // await checkVersion.initCheckVersion();
      // checkVersion.onChanged.stream.listen((status) {
      //   var updateAvailable = VersionStatus.updateAvailable == status;
      //   var unSupported = VersionStatus.unSupported == status;
      //   if (kReleaseMode) {
      //     if (updateAvailable || unSupported) {
      //       _bloc.add(AppMangerExpiredApp(isSupported: updateAvailable));
      //     } else {
      //       _bloc.add(AppMangerUnExpiredApp());
      //     }
      //   }
      // });
      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e) {
      completer.complete();
    }
    return completer.future;
  }
}
