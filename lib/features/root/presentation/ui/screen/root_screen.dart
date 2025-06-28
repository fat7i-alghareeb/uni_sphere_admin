// 🌎 Project imports:
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:uni_sphere_admin/features/home/presentation/ui/screens/home_view.dart';
import '../../../../../core/auth_data_source/local/auth_local.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/entities/user.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../shared/entities/role.dart';
import '../../../../announcements_management/presentation/ui/screens/news_view.dart';
import '../../../../subjects_management/presentation/ui/screens/sbuejcts_view.dart';
import '../../../../timetable_management/presentation/ui/screens/schedule_view.dart';
import '../../state/provider/nav_bar_provider.dart';
import '../widget/app_drawer.dart';
import '../widget/root_header.dart';
import '../widget/root_navbar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String pagePath = '/root';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return const RootScreen();
  };

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    User? user = getIt<AuthLocal>().getUser();
    if (user != null) {
      try {
        AppConstants.userRole = Role.values
            .firstWhere((element) => element.name == user.role.toLowerCase());
      } catch (e) {
        // If role name doesn't match any enum, default to unknown
        AppConstants.userRole = Role.unknown;
      }
    } else {
      AppConstants.userRole = Role.unknown;
    }
    super.initState();
  }

  String _getUserName() {
    try {
      final user = getIt<AuthLocal>().getUser();
      if (user != null) {
        return context.isEnglish
            ? '${user.firstNameEn} ${user.lastNameEn}'
            : '${user.firstNameAr} ${user.lastNameAr}';
      }
      return '';
    } catch (e) {
      debugPrint('Error getting user name: $e');
      return '';
    }
  }

  List<Widget> _getScreensForRole() {
    switch (AppConstants.userRole) {
      case Role.admin:
        return [
          const ScheduleView(),
          const NewsView(),
        ];
      case Role.professor:
        return [
          const SubjectsView(),
        ];
      case Role.superadmin:
        return [
          const SubjectsView(),
        ];
      case Role.systemcontroller:
        return [
          const HomeView(),
        ];
      case Role.unknown:
        return [
          const HomeView(),
        ];
    }
  }

  List<NavItem> _getNavItemsForRole() {
    switch (AppConstants.userRole) {
      case Role.admin:
        return [
          NavItem(iconPath: Assets.icons.timeTable, index: 0),
          NavItem(iconPath: Assets.icons.announcement, index: 1),
        ];
      case Role.professor:
        return [
          NavItem(iconPath: Assets.icons.subjects, index: 0),
        ];
      case Role.superadmin:
        return [
          NavItem(iconPath: Assets.icons.subjects, index: 0),
        ];
      case Role.systemcontroller:
        return [
          NavItem(iconPath: Assets.icons.home, index: 0),
        ];
      case Role.unknown:
        return [
          NavItem(iconPath: Assets.icons.home, index: 0),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final navProvider = Provider.of<NavBarProvider>(context);
    final screens = _getScreensForRole();
    final navItems = _getNavItemsForRole();

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: CustomEndDrawer(userRole: AppConstants.userRole),
      endDrawerEnableOpenDragGesture: true,
      body: Builder(
        builder: (context) {
          bool isClosingDrawer = false; // Track manual drawer close
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              final scaffoldState = Scaffold.maybeOf(context);

              // If we manually closed the drawer, ignore this pop event
              if (isClosingDrawer) {
                isClosingDrawer = false; // Reset flag
                return;
              }

              if (scaffoldState != null && scaffoldState.isEndDrawerOpen) {
                log("Closing end drawer...");
                isClosingDrawer = true; // Mark that we're manually closing
                Navigator.pop(context); // Close the drawer
                return;
              }

              // Proceed with normal logic if the drawer is not open
              if (navProvider.selectedIndex == 0) {
              } else {
                navProvider.changeSelected(0);
              }
            },
            child: CustomScaffoldBody(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      RootHeader(
                        userName: _getUserName(),
                        scaffoldKey: _scaffoldKey,
                      ),
                      Expanded(
                        child: PageView(
                          controller:
                              context.read<NavBarProvider>().pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: screens,
                        ),
                      ),
                    ],
                  ),
                  if (navItems.length > 1)
                    Positioned(
                      bottom: 25,
                      left: 0,
                      right: 0,
                      child: RootNavbar(navItems: navItems),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
