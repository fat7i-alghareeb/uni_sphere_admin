import 'package:flutter/foundation.dart';

import 'core/injection/injection.dart';
import 'shared/imports/imports.dart';

bootstrap(Widget mainApp) async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initInjection();
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
