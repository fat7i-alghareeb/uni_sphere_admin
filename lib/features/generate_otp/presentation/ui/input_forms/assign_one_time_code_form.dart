import 'package:reactive_forms/reactive_forms.dart';
import 'assign_one_time_code_input_keys.dart';

class AssignOneTimeCodeForm {
  static final formGroup = FormGroup({
    AssignOneTimeCodeInputKeys.studentNumber: FormControl<String>(),
    AssignOneTimeCodeInputKeys.oneTimeCode: FormControl<String>(),
    AssignOneTimeCodeInputKeys.targetType: FormControl<String>(),
    AssignOneTimeCodeInputKeys.selectedAdminId: FormControl<String>(),
    AssignOneTimeCodeInputKeys.selectedProfessorId: FormControl<String>(),
  });

  static void clear() {
    formGroup.reset();
  }
}
