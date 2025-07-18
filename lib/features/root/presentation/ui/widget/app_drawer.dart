// 📦 Package imports:
import 'package:beamer/beamer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart' show getIt;
import 'package:uni_sphere_admin/features/root/presentation/ui/screen/language_selection_screen.dart'
    show LanguageSelectionScreen;
import '../../../../../common/constant/app_strings.dart' show AppStrings;
import '../../../../../core/repo/auth_repo/auth_repo.dart';
import '../../../../../shared/widgets/theme_switcher.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/entities/role.dart';
import '../../../../grade_management/presentation/ui/screens/assign_grades_screen.dart'
    show AssignGradesScreen;

class CustomEndDrawer extends StatelessWidget {
  final Role userRole;

  const CustomEndDrawer({super.key, required this.userRole});

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
                  // Role-specific menu items
                  ..._buildRoleSpecificMenuItems(context),
                  12.verticalSpace,
                  // Common menu items
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
                      AppStrings.profile,
                      style: context.textTheme.titleMedium,
                    ),
                    onTap: () {
                      // Placeholder for profile screen
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    tileColor: context.cardColor,
                    contentPadding:
                        REdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  12.verticalSpace,
                  ListTile(
                    leading: Icon(Icons.logout, color: context.primaryColor),
                    title: Text(
                      AppStrings.logout,
                      style: context.textTheme.titleMedium,
                    ),
                    onTap: () {
                      getIt<AuthRepository>().logout();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    tileColor: context.cardColor,
                    contentPadding:
                        REdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
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

  List<Widget> _buildRoleSpecificMenuItems(BuildContext context) {
    switch (userRole) {
      case Role.admin:
        return [
          ListTile(
            leading: Icon(Icons.upload_file, color: context.primaryColor),
            title: Text(
              AppStrings.uploadGrades,
              style: context.textTheme.titleMedium,
            ),
            onTap: () {
              context.beamToNamed(AssignGradesScreen.pagePath);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            tileColor: context.cardColor,
            contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          12.verticalSpace,
          ListTile(
            leading: Icon(Icons.qr_code, color: context.primaryColor),
            title: Text(
              AppStrings.generateOneTimeCode,
              style: context.textTheme.titleMedium,
            ),
            onTap: () {
              context.beamToNamed('/root/assign_one_time_code');
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            tileColor: context.cardColor,
            contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
        ];
      case Role.professor:
        return []; // No additional menu items for professor
      case Role.superadmin:
        return [
          ListTile(
            leading: Icon(Icons.qr_code, color: context.primaryColor),
            title: Text(
              AppStrings.generateOneTimeCode,
              style: context.textTheme.titleMedium,
            ),
            onTap: () {
              context.beamToNamed('/root/assign_one_time_code');
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            tileColor: context.cardColor,
            contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          12.verticalSpace,
          ListTile(
            leading: Icon(Icons.people, color: context.primaryColor),
            title: Text(
              AppStrings.assignReassignProfessor,
              style: context.textTheme.titleMedium,
            ),
            onTap: () {
              // Placeholder for assign/reassign professor functionality
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
            tileColor: context.cardColor,
            contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
        ];
      case Role.systemcontroller:
        return []; // No additional menu items for system controller
      case Role.unknown:
        return []; // No additional menu items for unknown role
    }
  }
}
