// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class RegisterForm {
  static FormGroup formGroup = FormGroup({
    AuthInputKeys.userId: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    AuthInputKeys.password: FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(6),
      ],
    ),
    AuthInputKeys.confirmPassword: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  }, validators: [
    Validators.mustMatch(AuthInputKeys.password, AuthInputKeys.confirmPassword),
  ]);

  static void clearForm() {
    formGroup.reset();
  }
}
