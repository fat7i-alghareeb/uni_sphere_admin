// 📦 Package imports:
import 'package:beamer/beamer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_sphere_admin/features/root/presentation/ui/screen/language_selection_screen.dart'
    show LanguageSelectionScreen;
import '../../../../../common/constant/app_strings.dart' show AppStrings;
import '../../../../../shared/widgets/theme_switcher.dart';
import '../../../../../shared/imports/imports.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  // ignore: unused_element
  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version; // Fetches the app version
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: context.backgroundColor,
        width: context.screenWidth * 0.75,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.settings,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.textColor,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: const ThemeSwitcher(),
            ),
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.language, color: context.primaryColor),
                    title: Text(
                      AppStrings.language,
                      style: context.textTheme.titleMedium,
                    ),
                    onTap: () {
                      context.beamToNamed(LanguageSelectionScreen.pagePath);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    tileColor: context.cardColor,
                    contentPadding:
                        REdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  12.verticalSpace,
                  ListTile(
                    leading:
                        Icon(Icons.person_outline, color: context.primaryColor),
                    title: Text(
                      AppStrings.studentProfile,
                      style: context.textTheme.titleMedium,
                    ),
                    onTap: () {
                      //   context.beamToNamed('/root/${StudentScreen.pagePath}');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    tileColor: context.cardColor,
                    contentPadding:
                        REdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  12.verticalSpace,
                ],
              ),
            ),
            20.verticalSpace,
            const Spacer(),
            FutureBuilder<String>(
              future: _getAppVersion(),
              builder: (context, snapshot) {
                return Padding(
                  padding: REdgeInsets.all(16),
                  child: Text(
                    '${AppStrings.version} ${snapshot.data ?? "1.0.0"}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.textColor.withValues(alpha: .6),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
