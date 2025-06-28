import 'package:flutter/foundation.dart';
import 'package:uni_sphere_admin/core/auth_data_source/local/reactive_token_storage.dart' show ReactiveTokenStorage;

import 'core/injection/injection.dart';
import 'shared/imports/imports.dart';

bootstrap(Widget mainApp) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initInjection();
    await getIt<ReactiveTokenStorage>().loadToken();

    // await FirebaseNotificationImplService.initFirebase(DefaultFirebaseOptions.currentPlatform);
    // FirebaseNotificationImplService firebaseNotificationImplService = FirebaseNotificationImplService();
    // await firebaseNotificationImplService.setUpFirebase("channel_id");
    // printR(await firebaseNotificationImplService.getToken());
  } finally {
    if (kReleaseMode) {
      runApp(mainApp);
    } else {
      runApp(mainApp);
    }
  }
}
