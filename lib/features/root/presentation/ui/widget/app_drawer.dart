// 📦 Package imports:

// 🌎 Project imports:

import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../shared/extensions/context_extension.dart';

import '../../../../../shared/imports/imports.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version; // Fetches the app version
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        width: context.screenWidth * 0.75,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        )),
        child: const SizedBox());
  }
}
