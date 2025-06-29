// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// 🌎 Project imports:
import 'subject_management_input_keys.dart';

class SubjectManagementForm {
  static FormGroup formGroup = FormGroup(
    {
      SubjectManagementInputKeys.major: FormControl<String?>(),
      SubjectManagementInputKeys.majorId: FormControl<String?>(),
      SubjectManagementInputKeys.year: FormControl<int?>(),
      SubjectManagementInputKeys.yearId: FormControl<String?>(),
    },
  );

  static void clearForm() {
    formGroup.reset();
  }
}
