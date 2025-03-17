// 🌎 Project imports:
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';

import '../../../../../router/router_config.dart';

import '../../../../../shared/imports/imports.dart';
import '../../state/provider/nav_bar_provider.dart';
import '../widget/app_drawer.dart';
import '../widget/root_header.dart';
import '../widget/root_navbar.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  static const String pagePath = '/root';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    return BeamPage(
      key: ValueKey('lesson_words $id'),
      child: const RootScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    // getIt<NotificationsAndCartsUpdater>().openConnection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavBarProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const CustomEndDrawer(),
      body: Builder(builder: (context) {
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
          child: Column(
            children: [
              const RootHeader(),
              Expanded(
                child: PageView(
                  controller: context.read<NavBarProvider>().pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: const RootNavbar(),
    );
  }
}
