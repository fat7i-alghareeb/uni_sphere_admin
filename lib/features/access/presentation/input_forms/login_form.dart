// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class LoginForm {
  static FormGroup formGroup = FormGroup({
    AuthInputKeys.email: FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    AuthInputKeys.password: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  static void clearForm() {
    formGroup.reset();
  }
}
