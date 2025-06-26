// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'auth_input_keys.dart';

class CheckOneTimeCodeForm {
  static FormGroup formGroup = FormGroup(
    {
      AuthInputKeys.email: FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      AuthInputKeys.oneTimeCode: FormControl<String>(
        validators: [
          Validators.required,
        ],
      ),
      AuthInputKeys.faculty: FormControl<String?>(),
      AuthInputKeys.major: FormControl<String?>(),
      AuthInputKeys.majorId: FormControl<String?>(),
      AuthInputKeys.facultyId: FormControl<String?>(),
    },
  );

  static void clearForm() {
    formGroup.reset();
  }
}
