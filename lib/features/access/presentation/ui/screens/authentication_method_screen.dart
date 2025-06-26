import 'package:beamer/beamer.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart'
    show AppStrings;
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart'
    show AuthButton;
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;
import '../../../../../router/router_config.dart' show BeamerBuilder;
import '../../state/bloc/auth_bloc.dart' show AuthBloc;
import 'login_screen.dart' show LoginScreen;
import 'check_one_time_code_screen.dart' show CheckOneTimeCodeScreen;
import '../../../../../shared/entities/role.dart' show Role;

class AuthenticationMethodScreen extends StatelessWidget {
  const AuthenticationMethodScreen({super.key});
  static const String pagePath = 'authentication_method';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return const BeamPage(
      key: ValueKey("authentication_method"),
      child: AuthenticationMethodScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScaffoldBody(
        child: AuthenticationMethodBody(),
      ),
    );
  }
}

class AuthenticationMethodBody extends StatefulWidget {
  const AuthenticationMethodBody({super.key});

  @override
  State<AuthenticationMethodBody> createState() =>
      _AuthenticationMethodBodyState();
}

class _AuthenticationMethodBodyState extends State<AuthenticationMethodBody>
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

  String _getRoleDisplayName() {
    switch (AuthBloc.selectedRole) {
      case Role.admin:
        return AppStrings.admin;
      case Role.superAdmin:
        return AppStrings.superAdmin;
      case Role.professor:
        return AppStrings.professor;
      case Role.systemController:
        return AppStrings.systemController;
    }
  }

  IconData _getRoleIcon() {
    switch (AuthBloc.selectedRole) {
      case Role.admin:
        return Icons.admin_panel_settings;
      case Role.superAdmin:
        return Icons.supervisor_account;
      case Role.professor:
        return Icons.school;
      case Role.systemController:
        return Icons.settings_system_daydream;
    }
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
              child: Container(
                width: 120.r,
                height: 120.r,
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.primaryColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  _getRoleIcon(),
                  size: 60.r,
                  color: context.primaryColor,
                ),
              ),
            ),
            16.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  _getRoleDisplayName(),
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            30.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  AppStrings.chooseAuthenticationMethod,
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
                child: AuthMethodButton(
                  title: AppStrings.login,
                  icon: Icons.login,
                  onTap: () {
                    context.beamToNamed(LoginScreen.pagePath);
                  },
                ),
              ),
            ),
            20.verticalSpace,
            // Only show register option for roles that support it
            if (AuthBloc.selectedRole != Role.systemController)
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: AuthMethodButton(
                    title: AppStrings.register,
                    icon: Icons.person_add,
                    onTap: () {
                      context.beamToNamed(CheckOneTimeCodeScreen.pagePath);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AuthMethodButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const AuthMethodButton({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      title: title,
      onPressed: onTap,
      height: 50.h,
      borderRadius: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24.r,
          ),
          12.horizontalSpace,
          Text(
            title,
            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
