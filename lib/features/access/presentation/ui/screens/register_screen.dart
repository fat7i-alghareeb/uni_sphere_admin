import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:uni_sphere_admin/features/access/presentation/ui/widgets/register_body.dart';
import 'package:uni_sphere_admin/router/router_config.dart' show BeamerBuilder;
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart'
    show InfoBloc;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String pagePath = 'register';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("register"),
      child: const RegisterScreen(),
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
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<AuthBloc>()),
              BlocProvider.value(value: getIt<InfoBloc>()),
            ],
            child: RegisterBody(),
          ),
        ),
      ),
    );
  }
}
