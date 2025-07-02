import 'package:reactive_forms/reactive_forms.dart';
import 'add_lecture_input_keys.dart';

class AddLectureForm {
  static FormGroup formGroup = FormGroup({
    AddLectureInputKeys.subjectId: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    AddLectureInputKeys.startTime: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    AddLectureInputKeys.endTime: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    AddLectureInputKeys.lectureHallEn: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    AddLectureInputKeys.lectureHallAr: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  static void clearForm() {
    formGroup.reset();
  }
}
