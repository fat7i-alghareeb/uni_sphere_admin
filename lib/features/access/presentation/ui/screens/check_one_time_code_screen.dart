import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:uni_sphere_admin/features/access/presentation/ui/widgets/check_one_time_code_body.dart';
import 'package:uni_sphere_admin/router/router_config.dart' show BeamerBuilder;
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart'
    show InfoBloc;

class CheckOneTimeCodeScreen extends StatelessWidget {
  const CheckOneTimeCodeScreen({super.key});
  static const String pagePath = 'check_one_time_code';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("check_one_time_code"),
      child: const CheckOneTimeCodeScreen(),
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
            child: CheckOneTimeCodeBody(),
          ),
        ),
      ),
    );
  }
}
