import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart'
    show AppStrings;
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart'
    show AuthButton;
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart' show getColoredSvgPicture;
import 'authentication_method_screen.dart' show AuthenticationMethodScreen;
import '../../../../../shared/entities/role.dart' show Role;
import '../../../../../router/router_config.dart' show BeamerBuilder;

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  static const String pagePath = '/role_selection';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return const BeamPage(
      key: ValueKey("role_selection"),
      child: RoleSelectionScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScaffoldBody(
        child: RoleSelectionBody(),
      ),
    );
  }
}

class RoleSelectionBody extends StatefulWidget {
  const RoleSelectionBody({super.key});

  @override
  State<RoleSelectionBody> createState() => _RoleSelectionBodyState();
}

class _RoleSelectionBodyState extends State<RoleSelectionBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: getColoredSvgPicture(
                assetName: Assets.images.logoSvg,
                width: 250.w,
                height: 250.h,
                color: context.onBackgroundColor,
                // color: context.theme.colorScheme.primary,
              ),
            ),
            30.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  AppStrings.selectRole,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            80.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: RoleSelectionButton(
                  title: AppStrings.admin,
                  icon: Icons.admin_panel_settings,
                  onTap: () {
                    AuthBloc.selectedRole = Role.admin;
                    context.beamToNamed(AuthenticationMethodScreen.pagePath);
                  },
                ),
              ),
            ),
            20.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: RoleSelectionButton(
                  title: AppStrings.superAdmin,
                  icon: Icons.supervisor_account,
                  onTap: () {
                    AuthBloc.selectedRole = Role.superadmin;
                    context.beamToNamed(AuthenticationMethodScreen.pagePath);
                  },
                ),
              ),
            ),
            20.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: RoleSelectionButton(
                  title: AppStrings.professor,
                  icon: Icons.school,
                  onTap: () {
                    AuthBloc.selectedRole = Role.professor;
                    context.beamToNamed(AuthenticationMethodScreen.pagePath);
                  },
                ),
              ),
            ),
            // 20.verticalSpace,
            // FadeTransition(
            //   opacity: _fadeAnimation,
            //   child: SlideTransition(
            //     position: _slideAnimation,
            //     child: RoleSelectionButton(
            //       title: AppStrings.systemController,
            //       icon: Icons.settings_system_daydream,
            //       onTap: () {
            //         AuthBloc.selectedRole = Role.systemcontroller;
            //         context.beamToNamed(AuthenticationMethodScreen.pagePath);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const RoleSelectionButton({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AuthButton.primary(
      title: title,
      onPressed: onTap,
      context: context,
      height: 50.h,
      borderRadius: 16,
    );
  }
}
