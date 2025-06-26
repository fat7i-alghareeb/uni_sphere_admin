import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/core/injection/injection.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/features/access/data/params/login_param.dart';
import 'package:uni_sphere_admin/features/access/presentation/input_forms/auth_input_keys.dart';
import 'package:uni_sphere_admin/features/access/presentation/input_forms/login_form.dart';
import 'package:uni_sphere_admin/features/access/presentation/state/bloc/auth_bloc.dart';
import 'package:uni_sphere_admin/shared/extensions/form_extension.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_scaffold_body.dart';
import 'package:uni_sphere_admin/shared/widgets/passwrod_field.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  // Individual animations for each widget
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _loginInfoAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create staggered animations
    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.3, curve: Curves.elasticOut),
    ));

    _titleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeOutBack),
    ));

    _loginInfoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    ));

    _buttonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOutBack),
    ));

    // Start animations
    _fadeController.forward();
    _animationController.forward();

    // Clear form when entering screen
    LoginForm.clearForm();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();

    // Clear form when leaving screen
    LoginForm.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FadeTransition(
        opacity: _fadeController,
        child: ReactiveForm(
          key: ValueKey("login_form"),
          formGroup: LoginForm.formGroup,
          child: Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppConstants.horizontalScreensPadding,
            ),
            child: CustomScaffoldBody(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    75.verticalSpace,
                    AnimatedBuilder(
                      animation: _logoAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _logoAnimation.value)),
                            child: Container(
                              width: 150.r,
                              height: 150.r,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.login,
                                size: 80.r,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AnimatedBuilder(
                      animation: _titleAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - _titleAnimation.value)),
                          child: Opacity(
                            opacity: _titleAnimation.value.clamp(0.0, 1.0),
                            child: Text(
                              AppStrings.login,
                              style: context.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                    AnimatedBuilder(
                      animation: _loginInfoAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset:
                              Offset(-50 * (1 - _loginInfoAnimation.value), 0),
                          child: Opacity(
                            opacity: _loginInfoAnimation.value.clamp(0.0, 1.0),
                            child: _loginInfo(),
                          ),
                        );
                      },
                    ),
                    50.verticalSpace,
                    AnimatedBuilder(
                      animation: _buttonAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _buttonAnimation.value,
                          child: Opacity(
                            opacity: _buttonAnimation.value.clamp(0.0, 1.0),
                            child: BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state.loginResult.isError()) {
                                  showErrorOverlay(
                                    context,
                                    state.loginResult.getError(),
                                  );
                                }
                                if (state.loginResult.isLoaded()) {
                                  // Navigate to home or dashboard after successful login
                                  // You can add navigation logic here
                                }
                              },
                              builder: (context, state) {
                                return AuthButton.primary(
                                  height: 50.h,
                                  isLoading: state.loginResult.isLoading(),
                                  title: AppStrings.login,
                                  onPressed: () {
                                    // Check if form is valid
                                    if (!LoginForm.formGroup.isFormValid()) {
                                      showErrorOverlay(context,
                                          AppStrings.thisFieldRequired);
                                      return;
                                    }

                                    // If validation passes, proceed with login
                                    getIt<AuthBloc>().add(
                                      LoginEvent(
                                        loginParam: LoginParam(
                                          gmail: LoginForm.formGroup.getValue(
                                            AuthInputKeys.email,
                                          ),
                                          password:
                                              LoginForm.formGroup.getValue(
                                            AuthInputKeys.password,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  context: context,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginInfo() {
    return ReactiveFormConsumer(builder: (context, form, child) {
      return Column(
        children: [
          CustomReactiveField(
            controller: AuthInputKeys.email,
            hintText: AppStrings.enterEmail,
            title: AppStrings.email,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
          ),
          10.verticalSpace,
          PasswordField(
            isConfirmPassword: false,
            hintText: AppStrings.enterPassword,
            withTitle: true,
          ),
        ],
      );
    });
  }
}
