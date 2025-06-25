// 🌎 Project imports:
import 'dart:developer';
import 'package:provider/provider.dart';
import '../../../../../core/auth_data_source/local/auth_local.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';

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
    // getIt<NotificationsAndCartsUpdater>().openConnection();
    super.initState();
  }

  String _getUserName() {
    try {
      final user = getIt<AuthLocal>().getUser();
      if (user != null) {
        return '${user.firstName} ${user.lastName}';
      }
      return '';
    } catch (e) {
      debugPrint('Error getting user name: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final navProvider = Provider.of<NavBarProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: const CustomEndDrawer(),
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
                          children: const [
                            // HomeScreen(),
                            // SubjectsScreen(),
                            // TimetableScreen(),
                            // AnnouncementScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child: RootNavbar(),
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
