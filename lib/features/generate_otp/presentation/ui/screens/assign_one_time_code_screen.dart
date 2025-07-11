import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/core/constants/app_constants.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/shared/entities/role.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:uni_sphere_admin/shared/widgets/spacing.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/state/bloc/generate_otp_bloc.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:beamer/beamer.dart';
import '../input_forms/assign_one_time_code_form.dart';
import '../widgets/admin_assign_one_time_code_section.dart';
import '../widgets/superadmin_assign_one_time_code_section.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';

class AssignOneTimeCodeScreen extends StatefulWidget {
  const AssignOneTimeCodeScreen({super.key});

  static const String pagePath = 'assign_one_time_code';
  static dynamic pageBuilder = (context, state, data) {
    return BeamPage(
      key: const ValueKey('assign_one_time_code_screen'),
      child: const AssignOneTimeCodeScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<AssignOneTimeCodeScreen> createState() =>
      _AssignOneTimeCodeScreenState();
}

class _AssignOneTimeCodeScreenState extends State<AssignOneTimeCodeScreen> {
  @override
  void initState() {
    super.initState();
    AssignOneTimeCodeForm.clear();
    if (AppConstants.userRole == Role.superadmin) {
      getIt<InfoBloc>().add(GetUnregisteredAdminsByFacultyEvent());
      getIt<InfoBloc>().add(GetProfessorsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<InfoBloc>()),
          BlocProvider.value(value: getIt<GenerateOtpBloc>()),
        ],
        child: ReactiveForm(
          formGroup: AssignOneTimeCodeForm.formGroup,
          child: CustomScaffoldBody(
            title: AppStrings.generateOneTimeCode,
            child: Padding(
              padding: REdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalScreensPadding),
              child: BlocConsumer<GenerateOtpBloc, GenerateOtpState>(
                listener: (context, state) {
                  if (state.result.isLoaded()) {
                    AssignOneTimeCodeForm.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.oneTimeCodeAssignedSuccess),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state.result.isError()) {
                    showErrorOverlay(context, state.result.getError());
                  }
                },
                builder: (context, otpState) {
                  return BlocBuilder<InfoBloc, InfoState>(
                    builder: (context, infoState) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.verticalSpace,
                            if (AppConstants.userRole == Role.admin)
                              AdminAssignOneTimeCodeSection(
                                infoState: infoState,
                                otpState: otpState,
                              ),
                            if (AppConstants.userRole == Role.superadmin)
                              SuperAdminAssignOneTimeCodeSection(
                                infoState: infoState,
                                otpState: otpState,
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
