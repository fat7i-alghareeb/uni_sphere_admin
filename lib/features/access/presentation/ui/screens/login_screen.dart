import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart' show getIt;
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:uni_sphere_admin/features/access/presentation/ui/widgets/login_body.dart';
import 'package:uni_sphere_admin/router/router_config.dart' show BeamerBuilder;
import 'package:uni_sphere_admin/shared/imports/imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String pagePath = 'login';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("login"),
      child: const LoginScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: ValueKey(context.locale),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocProvider.value(
            value: getIt<AuthBloc>(),
            child: LoginBody(),
          ),
        ),
      ),
    );
  }
}
